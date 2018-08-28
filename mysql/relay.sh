#!/bin/bash
# Mysql Master/Slave Server Create Script
fire(){
systemctl enable firewalld;systemctl stop firewalld
echo "已永久关闭防火墙"
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
mysql -uroot -pqa -h192.168.1.10 -e "delete from user where user='slave'" &>/dev/null
mysql -uroot -pqa -h192.168.1.10 -e "grant replication slave,replication client on *.* to 'slave'@'192.168.1.%' identified by 'qa'"
}
mstat=`mysql -uslave -pqa -h192.168.1.10 -e "show master status\G" >/tmp/mstat.txt`
slstat=`mysql -uroot -pqa  -e"show slave status\G" >/tmp/slstat.txt`
logfile=`mysql -uslave -pqa -h192.168.1.10 -e"show master status\G" |awk '{print $2}' |head -2|tail -1`
logpos=`mysql -uslave -pqa -h192.168.1.10 -e"show master status\G" |awk '{print $2}' |head -3|tail -1`
slave_io=`cat /tmp/slstat.txt|awk '$1 ~ /Slave_IO_Running:/{print $2}'`
slave_sql=`cat /tmp/slstat.txt|awk '$1 ~ /Slave_SQL_Running:/{print $2}'`

#---------------------------
echo -e "请选择需要配置的服务器模式 1或2 ：\n1.主服务器模式/Master/A\n2.从服务器模式/Slave/B\n"
read mode
case $mode in
1)  
  fire;sel;mycnfa;mycnfb;resql;slu
  echo -e "------------------------------\nmysql主服务器创建已经完成\n请留意以下输出的master status的结果\n"
  mstat
  cat /tmp/mstat.txt
  echo -e "\n---------------------------------\n请在Slave从服务器上以slave为用户名，qa为密码进行账户测试\nUsage: mysql -uslave -pqa -h 'your Master host IP address'" 
  ;;
2)
  fire;sel;mycnfa;resql;mstat
  mysql -uroot -pqa -e "change master to master_host='192.168.1.10',master_port=3306,master_user='slave',master_password='qa',master_log_file='$logfile',master_log_pos=$logpos;"
  mysql -uroot -pqa -e "slave start"
  echo -e "------------------------------\nmysql从服务器创建已经完成\n请留意以下输出的slave status的结果\n"
  slstat
  cat /tmp/slstat.txt
  ;;
esac

