#!/bin/bash
# pxe install
dvddir=/mnt/dvd
repodir=/etc/yum.repos.d
umount /dev/sr0
test -d $dvddir
if [ $? -eq 1 ];then
mkdir $dvddir
fi
mount /dev/sr0 $dvddir
test -d ${repodir}/bak/
if [ $? -eq 1 ];then
mkdir ${repodir}/bak/
fi
mv ${repodir}/*.repo ${repodir}/bak &>/dev/null
systemctl stop firewalld
setenforce 0
echo "[local]
name=local
baseurl=file://$dvddir
gpgcheck=0" >${repodir}/local.repo
yum clean all;yum repolist
yum install -y dhcp vsftpd tftp-server syslinux
echo 'subnet 192.168.2.0 netmask 255.255.255.0 {
  range 192.168.2.100 192.168.2.200;
  default-lease-time 600;
  max-lease-time 7200;
  filename "pxelinux.0";
  next-server 192.168.2.254;
}'>/etc/dhcp/dhcpd.conf
echo "BOOTPROTO=none
ONBOOT=yes
DEVICE=ens33
IPADDR=192.168.2.254">/etc/sysconfig/network-scripts/ifcfg-ens33
/etc/init.d/network restart
systemctl restart dhcpd
sed -i '/disable/c\\tdisable\t\t\t= no' /etc/xinetd.d/tftp
systemctl restart tftp
cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
cp ${dvddir}/isolinux/vmlinuz ${dvddir}/isolinux/initrd.img ${dvddir}/isolinux/vesamenu.c32 /var/lib/tftpboot/
test -d /var/lib/tftpboot/pxelinux.cfg
if [ $? -eq 1 ];then
mkdir /var/lib/tftpboot/pxelinux.cfg/
fi
cp  ${dvddir}/isolinux/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default
sed -i '64c\\tappend initrd=initrd.img ks=ftp://192.168.2.254/ks.cfg' /var/lib/tftpboot/pxelinux.cfg/default
sed -i '/menu default/d' /var/lib/tftpboot/pxelinux.cfg/default
sed -i '/menu label ^Install CentOS Linux 7/a\\tmenu default' /var/lib/tftpboot/pxelinux.cfg/default
#sed -i '/label check/, +53d' /var/lib/tftpboot/pxelinux.cfg/default
systemctl restart vsftpd
mount /dev/sr0 /var/ftp/pub
echo '#platform=x86, AMD64, 或 Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Keyboard layouts
keyboard 'us'
# Root password
rootpw --iscrypted $1$.J1lVKYe$35TToy0HfPmpdv9s5jvKg.
# Use network installation
url --url="ftp://192.168.2.254/pub"
# System language
lang en_US
# Firewall configuration
firewall --disabled
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use graphical install
text
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx

# Reboot after installation
reboot
# System timezone
timezone Africa/Abidjan
# System bootloader configuration
bootloader --location=mbr
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --size=1024
part / --fstype="xfs" --grow --size=1

%packages
@base
@core
#@dns-server
#@fonts
#@ftp-server
#@java-platform
#@legacy-unix
#@legacy-x
#@load-balancer
#@network-file-system-client
#@network-server
#@perl-runtime
#@php
#@python-web
#@ruby-runtime
#@web-server
#@x11

%end'>/var/ftp/ks.cfg
