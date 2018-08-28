#!/bin/bash

kaishi(){ 
systemctl start httpd 
}  
jieshu(){
systemctl stop httpd
}
zt(){
systemctl status httpd
}
hd(){
/dev/null
 }
 case $1 in
 start) 
 zt &>hd
   if [ $? -eq 0 ];then
   echo "启动失败，服务已在运行"
   else
     if httpd -t &>hd;[ $? -eq 1 ];then
       echo "配置文件语法有错误，禁止启动服务"
     else  kaishi ;echo "httpd now is started"
     fi
fi ;;
stop)
zt &>hd
 if [ $? -eq 3 ];then
 echo "停止失败，服务未运行"
 else
   if httpd -t &>hd;[ $? -eq 1 ];then
     echo "配置文件语法有错误，禁止停止服务"
   else jieshu;echo "httpd now is stop"
   fi
 fi ;;
restart) 
zt &>hd
  if httpd -t &>hd;[ $? -eq 1 ];then
    echo "配置文件语法有错误，禁止重启服务"
  else jieshu;kaishi;echo "httpd now is restart"
  fi ;;
esac
