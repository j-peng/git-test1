#!/bin/bash
echo -e "请输入要计算的表达式，支持（），加减乘除"
read  a
echo "$a"|bc
