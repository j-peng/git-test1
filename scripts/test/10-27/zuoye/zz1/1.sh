#!/bin/bash
# 成绩判断
while read -p "请输入要查询的分数" count
do

if [ $count = exit ];then
echo "程序退出";exit
elif [ $count -le 100 ]&>/dev/null;then
case $count in
9[0-9]|100) echo "非常优秀";;
8[0-9]) echo "优秀";;
7[0-9]) echo "良好";;
6[1-9]) echo "还需努力成绩不理想";;
60) echo "刚刚及格";;
[0-9]|[1-5][0-9]) echo "差";;
esac
elif [ $count -le 100 ]&>/dev/null;[ $? -gt 0 ]&>/dev/null;then
echo "输入的内容不正确，请重新输入"
else
echo "输入的内容不正确，请重新输入"
fi
done
