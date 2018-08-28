#! /bin/bash
#向所有用户问好
for i in `grep "/bin/bash$"  /etc/passwd|cut -d : -f 1` 
set -x
do
echo "hello $i"
done
set +x
