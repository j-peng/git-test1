#! /bin/bash
read -p "请输入要查询是否存在的用户名:" usname
id $usname &>/dev/null
if [ $? -eq 0 ];then 
echo "用户 ${usname} 已存在" 
else 
echo "用户 ${usname} 不存在" 
fi 
#根据查看tom用户的id信息命令的执行返回值来判断当前系统中是否已有tom用户.
