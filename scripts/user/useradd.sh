#!/bin/bash
#Useradd
#J.P.Wu 170926-0.0.1
useradd user1;echo "user user1 added."
useradd user2;echo "user user2 added."
useradd user3;echo "user user3 added."
useradd user4;echo "user user4 added."
useradd user5;echo "user user5 added."
echo user1|passwd --stdin user1 &>/dev/null
echo user2|passwd --stdin user2 &>/dev/null
echo user3|passwd --stdin user3 &>/dev/null
echo user4|passwd --stdin user4 &>/dev/null
echo user5|passwd --stdin user5 &>/dev/null
