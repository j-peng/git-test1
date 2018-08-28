#!/bin/bash
read -p "请输入IP地址" ifping
ping -c 2 $ifping
if [ $? -eq 0 ];then
 echo
 echo "ip is up"
else
 echo
 echo "ip is down"
fi
