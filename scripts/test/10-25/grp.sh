#!/bin/bash
read -p "please input line number:" lnum
read -p "please input count:" count
for b in `seq 1 $lnum`
 do
  for ((a=1;a<=$count;a++))
  do
   echo -n "*"
  done
 echo
 done
