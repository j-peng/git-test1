#! /bin/bash
# 删除实验环境多余的账户
for i in `awk -F: '/\/bin\/bash$/{print $1}' /etc/passwd|sed "/root/d;/test/d"`
do
	userdel -r $i
done
