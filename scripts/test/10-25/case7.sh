#!/bin/bash
read -p "请输入要查询的分数" cjcx
case $cjcx in
[0]|[0-5][0-9])
  echo "差";;
[6-7][0-9])
  echo "良";;
[8-9][0-9]|100)
  echo "优";;
*)
  echo "输入不合法"''
esac
