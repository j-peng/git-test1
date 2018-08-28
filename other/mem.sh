memuser=`free |awk '{print $3}'|head -2|tail -1`
memtotal=`free |awk '{print $2}'|head -2|tail -1`
a=`echo "scale=2;($memuser/$memtotal)*100"|bc`
b=`printf "%1.2s\n" $a`
memin=`printf "%1.2s\n" $a`
#echo "内存使用量为${memin}%"
if [ $memin -ge '80' ];then
  echo "内存使用量为${memin}%";exit 2
elif [ $memin -gt '40' ] && [ $memin -le '80' ];then
echo "内存使用量为${memin}%";exit 1
elif [ $memin -le '40' ];then
echo "内存使用量为${memin}%";exit 0
fi
