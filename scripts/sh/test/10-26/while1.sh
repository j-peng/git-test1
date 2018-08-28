#!/bin/bash
#i=0
#while [ $i -le 10 ]
while read -p "请输入计算公式" b
  do
    #echo $i
    #let i++
    #i=$[$i+1]
    echo "scale=2;$b"|bc
    if [ $b = exit ];then
    exit
    fi
  done
