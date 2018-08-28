#! /bin/bash
#分区用
parted /dev/sdb mklabel gpt  y 
parted /dev/sdb mkpart primary 1  800M  
for i in {1..4}
	do
	a="$[800 * $i]"
	b=$[800 + $a]
	parted /dev/sdb mkpart primary   ${a}M      ${b}M   
	done
	#parted /dev/sdb mkpart primary   3200M  -1
