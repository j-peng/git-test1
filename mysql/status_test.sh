slave_io=`grep "Slave_IO_Running:" /tmp/slstat.txt|awk '{print $2}'`
slave_sql=`grep "Slave_SQL_Running:" /tmp/slstat.txt|awk '{print $2}'`
if [[ $slave_io -eq "Yes" ]] && [[ $slave_sql -eq "Yes" ]];then
  echo "All OK"
  elif [[ $slave_io -eq "No" ]] && [[ $slave_sql -eq "Yes" ]];then
  echo "Slave_IO Error"
  elif [[ $slave_io -eq "Yes" ]] && [[ $slave_sql -eq "No" ]];then
  echo "Slave_SQL Error"
  elif [[ $slave_io -eq "No" ]] && [[ $slave_sql -eq "No" ]];then
  echo "All Error"
fi
