#!/bin/bash
#
mkdir /mnt/centos7
mount /dev/sr0 /mnt/centos7
echo -e "[local_repo]\nname=local\nbaseurl=file:///mnt/centos7\ngpgcheck=0" >>/etc/yum.repos.d/localyum.repo
