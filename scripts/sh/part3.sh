#!/bin/bash
read -p "请输入您准备分几个区:" num
read -p "请输入分区大小:" a
parted /dev/sdb mklabel gpt y
parted /dev/sdb mkpart primary 1 ${a}M
for i in {seq $[$num - 2]}
   do
   parted /dev/sdb mkpart primary $[${i} * $a]M $[[${i} + 1] * $a]M
   done
parted /dev/sdb mkpart primary $[[${i} + 1] * $a]M "'-1'"
