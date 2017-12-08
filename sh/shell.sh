#!/bin/bash
#systeminfo
#J.P.Wu Version:170926-0.0.1
echo "系统磁盘信息："
df -h
echo "系统内存信息："
free -m
echo "当前登录的用户:`echo ${USER}`"
echo "本机以太网IP地址:"
ifconfig|head -2|tail -1|tr -s " " " "|cut -d " " -f 3  
ifconfig|grep inet|head -1|tr -s " "|cut -d " " -f 3
echo "当前系统日期时间："
date
echo "当前可以登录到系统的用户：`grep -c "/bin/bash$" /etc/passwd`个"
grep "/bin/bash$" /etc/passwd
echo "当前系统的主机名:"echo ${HOSTNAME}
