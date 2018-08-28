#!/bin/bash
#Userdel
#J.P.Wu 170926-0.0.1

#for a in user1 user2 user3 user4 user5 user6
#	do
#		useradd  $a
#		echo "${a}用户创建成功"
#		echo
#	done
#
#
for a in {1..90}
	do
		userdel -r  user$a
		#echo "user${a}用户现在已删除"
	done

