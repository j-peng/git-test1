#! /bin/bash
for i in user{1..70}
do
	rm -rf /var/spool/mail/$i
	rm -rf /home/$1
	echo 用户 $i 现在已删除
done
