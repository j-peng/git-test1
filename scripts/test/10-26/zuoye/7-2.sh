#!/bin/bash
cj=(`cut -d " " -f 2 /root/1/newname.txt`)
aa=${#cj[*]}
echo -e "\r${cj[$RANDOM%$aa]}  "
