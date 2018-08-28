#!/bin/bash
#自动分区脚本
echo -e "欢迎使用本自动分区脚本\n分区之前需要你指定要分区的设备、分区大小、大小单位\n除了最后一个分区使用全部剩余空间外\n其他所有分区的空间大小与您指定的大小一致\n"
read -p "请输入要分区的设备名(例: /dev/sdb)：" device
read -p "请输入每个分区的大小，只支持输入正整数：" size
read -p "请输入分区大小单位(K,M,G)：" unit
parted ${device} mklabel gpt y &>/dev/null
parted ${device} mkpart primary 1 ${size}${unit} &>/dev/null
for i in {1..3}
do
parted ${device} mkpart primary $[$size * $i ]${unit} $[$size * ($i + 1)]${unit} &>/dev/null
done
parted ${device} mkpart primary $[$size * 4]${unit} "'-1'" &>/dev/null
echo
echo "自动分区完成,以下是分区结果："
fdisk ${device} -l 2>/dev/null
echo
echo -e "是否需要保留分区结果?\n保留请输入y，不保留请输入n"
read ifdesk &>/dev/null
case $ifdesk in
  y)
  echo "分区已保留"
  ;;
  n)
  for b in {1..5}
  do
  parted /dev/sdb rm $b &>/dev/null
  done
  echo "分区已删除"
  ;;
  *)
  echo "输入错误：只能输入{yes|Y|no|N}"
  ;;
esac
echo "脚本执行完成，感谢您的使用"
