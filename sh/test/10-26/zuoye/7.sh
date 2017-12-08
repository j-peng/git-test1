#!/bin/bash
cj=(`cut -d " " -f 2 /root/1/newname.txt`)
aa=${#cj[*]}
for i in `seq 1 $aa`
do echo -ne "\r${cj[$RANDOM%$aa]}  ";sleep 0.2;done;echo

#cj=(`cut -d " " -f 2 /root/1/newname.txt`)
#aa=${#cj[*]}
#echo -e "\r${cj[$RANDOM%$aa]}  "
