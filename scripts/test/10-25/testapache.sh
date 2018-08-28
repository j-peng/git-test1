case $1 in
start)
systemctl start httpd;;
stop)
systemctl stop httpd;;
restart)
systemctl restart httpd;;
*)
echo "Usage：$0 {start|stop|restart}"
esac
