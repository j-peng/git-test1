#! /bin/bash
for i in user1 user2 user3 user4 user5
do
	useradd $i
	echo $i|passwd --stdin $i &>/dev/null
	echo "user $i added."
done


