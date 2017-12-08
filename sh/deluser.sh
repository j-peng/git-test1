#! /bin/bash
for i in `grep "/bin/bash$" /etc/passwd|cut -d : -f 1|grep -v root|grep -v peng`
do
	userdel -r $i
done
