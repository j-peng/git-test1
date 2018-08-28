#!/bin/bash
num=1
for a in {1..9999}
  do
    sum=$[ $sum + $a ]
  done
echo $sum
