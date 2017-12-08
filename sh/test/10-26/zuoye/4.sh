#!/bin/bash
for a in `seq 1 2 9999`
  do
    sum=$[ $sum + $a ]
  done
echo $sum
