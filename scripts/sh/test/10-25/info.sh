#!/bin/bash
echo -e  "输入'C'可查看CPU信息\n输入'M'可查看内存信息\n输入'D'可查看磁盘信息\n输入'Q'退出"
read  pcinfo
case $pcinfo in
C|c)
lscpu;;
M|m)
free -h;;
D|d)
fdisk -l;;
Q|q)
exit;;
*)
echo "Usage:you can input <c|m|d|q>";;
esac
