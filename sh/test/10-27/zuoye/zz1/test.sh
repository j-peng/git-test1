#!/bim/bash
commod(){
yum repolist|tail -1|awk -F "," '{print $2}'
}
if [[ $commod = 0 ]];then
echo "no"
else echo "yes"
fi
