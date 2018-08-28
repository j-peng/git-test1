 mysql -uroot -pqa -e"show slave status\G" >/tmp/slstat.txt
 slave_io=`grep "Slave_IO_Running:" /tmp/slstat.txt|awk '{print $2}'`
 slave_sql=`grep "Slave_SQL_Running:" /tmp/slstat.txt|awk '{print $2}'`
# $slstat
 if [[ $slave_io = 'No' ]] && [[ $slave_sql = 'No' ]];then
 echo "主从状态异常，请重新配置从服务器slave设置";exit 2
 elif [[ $slave_io != 'Yes' ]] && [[ $slave_sql -eq 'Yes' ]];then
 echo "从服务器IO线程异常，请检查主服务器与从服务器的网络通信";exit 1
 elif [[ $slave_io = 'Yes' ]] && [[ $slave_sql != 'Yes' ]];then
 echo "从服务器SQL线程异常，请检查从服务器slave配置";exit 1
 elif [[ $slave_io = 'Yes' ]] && [[ $slave_sql = 'Yes' ]];then
 echo "主从状态正常";exit 0
 fi
 rm -rf /tmp/slstat.txt
