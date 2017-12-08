#!/bin/bash
# Mysql Master/Slave Server Create Script
# 吴江鹏
fire(){
systemctl disable firewalld;systemctl stop firewalld
echo "已关闭防火墙"
}
sel(){
sed -i 's#SELINUX=permissive#SELINUX=disabled#' /etc/selinux/config
echo "Selinux 已关闭"

}
mycnfa(){
sed -i "/mysqld]/a\server-id=`date +%m%d%H%M%S`" /etc/my.cnf
echo "服务器标识(server-id)已修改"
}
mycnfb(){
sed -i "/mysqld]/a\log-bin=/var/lib/mysql/bintest.log" /etc/my.cnf
echo "二进制日志文件已生成"
}
resql(){
echo "正在重启mariadb服务"
systemctl restart mariadb
}
slu(){
echo "正在创建slave从服务账户"
mysql -e "delete from user where user='slave'" &>/dev/null
mysql -e "grant replication slave,replication client on *.* to 'slave'@'192.168.1.%' identified by 'qa'"
}
mstat=`mysql -e "show master status\G" >/tmp/mstat.txt`
slstat=`mysql -e"show slave status\G" >/tmp/slstat.txt`
logfile=`mysql -e"show master status\G" |awk '{print $2}' |head -2|tail -1`
logpos=`mysql -e"show master status\G" |awk '{print $2}' |head -3|tail -1`
slave_io=`grep "Slave_IO_Running:" /tmp/slstat.txt|awk '{print $2}'`
slave_sql=`grep "Slave_SQL_Running:" /tmp/slstat.txt|awk '{print $2}'`


#---------------------------
echo -e "请选择需要配置的服务器模式 1或2 ：\n1.主服务器模式/Master/A\n2.从服务器模式/Slave/B\n"
read mode
case $mode in
1|a|A|master|Master)  
  fire;sel;mycnfa;mycnfb;resql;slu
  mstat
  cat /tmp/mstat.txt
  echo -e "\n---------------------------------\n请在Slave从服务器上以slave为用户名，qa为密码进行账户测试\nUsage: mysql -uslave -pqa -h 'your Master host IP address'" 
  rm -rf /tmp/mstat.txt
  ;;
2|b|B|slave|Slave)
  fire;sel;mycnfa;resql;mstat
  mysql -e "change master to master_host='192.168.1.10',master_port=3306,master_user='slave',master_password='qa',master_log_file='$logfile',master_log_pos=$logpos;"
  mysql -e "slave start"
  slstat
    if [[ $slave_io -eq "Yes" ]] && [[ $slave_sql -eq "Yes" ]];then
      echo "All OK"
      elif [[ $slave_io -eq "No" ]] && [[ $slave_sql -eq "Yes" ]];then
      echo "Slave_IO Error"
      elif [[ $slave_io -eq "Yes" ]] && [[ $slave_sql -eq "No" ]];then
      echo "Slave_SQL Error"
      elif [[ $slave_io -eq "No" ]] && [[ $slave_sql -eq "No" ]];then
      echo "All Error"
    fi
  rm -rf /tmp/mstat.txt
  rm -rf /tmp/slstat.txt
  ;;
esac
