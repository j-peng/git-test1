#!/bin/bash
c=1
until [ $c -gt 5 ]
  do
    useradd user${c};echo user${c}|passwd --stdin user${c};let c++
  done
