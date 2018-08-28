#!/bin/bash
#记录银行卡号与密码
read -p "请输入银行卡号：" num
echo " 银行卡号 ${num}" >>/tmp/bandcard.txt
read -p "请输入卡密码：" mima
echo " 银行卡密码  ${mima}" >>/tmp/bandcard.txt
echo >>/tmp/bandcard.txt
