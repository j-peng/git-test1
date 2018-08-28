#!/bin/bash
read -p "please input 'J' or '0'" calc
case $calc in
J|j)
for a in `seq 1 2 99`
  do
    sum=$[ $sum + $a ]
  done
echo $sum ;;
0|O|o)
for a in `seq 2 2 100`
  do
   sum=$[ $sum + $a ]
  done
echo $sum ;;
esac
