#!/bin/bash
#DNS,Apache,Nginx综合部署
#2017-11-24
echo -e "请按序号选择部署的内容，输入 exit 退出程序\n1、DNS （bind）\n2、Apache（Web Server）\n3、Nginx（Web Server）\n"
while read bushu
do
case $bushu in
1)
  yum install bind bind-chroot -y;echo;;
2)
  yum remove httpd httpd-tools -y
  yum install libxml2-devel bzip2-devel -y
  userdel -r httpd &>/dev/null
  useradd -M -s /sbin/nologin httpd
  cd /usr/local;tar xf httpd-2.4.23.tar.gz -C /usr/src/
  cd /usr/src/httpd-2.4.23/
  ./configure --prefix=/usr/local/apache --sysconfdir=/etc/httpd --enable-modules=all --enable-mods-shared=all --enable-so --enable-ssl --enable-cgi --enable-rewrite --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util/ --with-pcre --with-libxml2 --with-mpm=event --enable-mpms-shared=all
  cd /usr/src/httpd-2.4.23/
  make && make install
  echo "export PATH=$PATH:/usr/local/apache/bin" >>/ /etc/profile.d/httpd.sh
  . /etc/profile.d/httpd.sh
  echo;;
3)
  userdel -r nginx &>/dev/null
  useradd -M -s /sbin/nologin nginx
  cd /usr/local/;tar xf nginx-1.8.1.tar.gz
  cd nginx-1.8.1
  ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_stub_status_module  --with-http_ssl_module
  cd nginx-1.8.1
  make && make install
  echo "export PATH=$PATH:/usr/local/nginx/sbin" >>/etc/profile.d/httpd.sh
  . /etc/profile.d/httpd.sh
  echo;;
exit)
  exit 0;;
*)
 echo "无效的输入，请按提示输入";;
esac
done
