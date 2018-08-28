#!/bin/bash
for ((a=1;a<=5;a++))
  do
    useradd user${a};echo user${a}|passwd --stdin user${a}
  done
 
