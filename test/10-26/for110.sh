#!/bin/bash
#
for ((i=2;i<=10;i=i+2))
 do
   echo $i
 done

 for ((a=1;a<=10,a++))
   do
     if [[$[$a%2]] -eq 0];then
     echo $a
     fi
   done
