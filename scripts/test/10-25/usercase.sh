#!/bin/bash
read -p "请输入用户名" uname
read -p "请输入密码" pas
case $uname,$pas in
jim,123)
  echo "Login OK";;
tom,456)
  echo "Login OK";;
jack,789)
  echo "Login OK";;
*)
  echo "Login NG";;
esac
