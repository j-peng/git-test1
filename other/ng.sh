#!/bin/bash
#nginx并发简单监控
ngnu=`curl -s 9.9.9.18/status|awk '/^Active/{print $3}'`
if [ $ngnu -le 3 ] ;then
    echo -e "当前并发数 $ngnu\n"
    echo "负载正常"
    exit 0
  elif [[ $ngnu -gt 3 ]] && [[ $ngnu -le 10 ]];then
    echo -e "当前并发数 $ngnu\n"
    echo "负载报警"
    exit 1
  else 
    echo -e "当前并发数 $ngnu\n"
    echo "负载警告"
    exit 2
fi

