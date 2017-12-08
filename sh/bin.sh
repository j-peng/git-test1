#!/bin/bash
#echo "请输入要查询的命令"
read -p "请输入要查询的命令:" comm
echo "${comm}命令由软件包$(rpm -qf $(which ${comm}))提供"
