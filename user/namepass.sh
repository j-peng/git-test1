#!/bin/bash
read -p "请输入用户名" uname
read -p "请输入密码" pswd
[ $uname = $pswd ]
if [ $? -eq 0 ];then
  echo "用户名和密码相同，需要重新设置密码"
  [ $uname $pswd ]
elif [ $? -eq 0 ];then
  echo "密码不合格，请重新设置密码"
  [ $uname $pswd ]
elif [ $? -eq 0 ];then
else
    echo "ok"
fi

