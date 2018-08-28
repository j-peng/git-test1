#!/bin/bash
read -p "请输入要查询的软件包名：" fpack
rpm -q $fpack &>/dev/null
if [ $? -eq 0 ];then
 echo "软件包${fpack}已安装，包名是:"
 rpm -q $fpack
else
 echo "软件包${fpack}尚未安装，将为您自动安装"
 yum install $fpack y
 echo "安装完成"
fi
