#!/bin/bash
read -p "请输入一个网段，例如 192.168.1.0：" iptest
#teping2 (){ echo ${iptest}|cut -d . -f -3 }
#teping3 (){ echo ${iptest}|cut -d . -f -3 }
testping (){ ${iptest}|cut -d . -f -3 }
for i in {1..10}
  do
    ping -c 1 testping.$i
  done
