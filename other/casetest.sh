#!/bin/bash
#echo -e "请输入状态:\rstart/stop/restart"
#read filecr
filecreate () { touch /tmp/start.txt }
filedel () { rm -rf /tmp/start.txt }
case $1 in
start)
 filecreate;;
stop)
 filedel;;
restart)
filecreate;filedel;;
*)
echo -e "输入错误，请重新执行\n只能输入{ start | stop | restart }";;
esac
