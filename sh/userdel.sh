#!/bin/bash
#Userdel user1~user5
#J.P.Wu 170926-0.0.1
#userdel -r user1;echo "user1用户现在已删除"
#userdel -r user2;echo "user2用户现在已删除"
#userdel -r user3;echo "user3用户现在已删除"
#userdel -r user4;echo "user4用户现在已删除"
#userdel -r user5;echo "user5用户现在已删除"

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

