#!/bin/bash
b=1
while [ $b -le 5 ]
  do
  useradd user${b};echo user${b}|passwd --stdin user${b};let b++
  done
