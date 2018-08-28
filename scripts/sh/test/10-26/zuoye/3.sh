#!/bin/bash
for a in `seq 2 2 9998`
  do
    sum=$[ $sum + $a ]
  done
echo $sum
