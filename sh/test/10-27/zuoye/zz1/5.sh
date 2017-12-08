yumrepolist(){
mkdir //mnt/centos7
mount /dev/dr0 /mnt/centos7
mkdir /etc/yum.repo.d/repobak
mv /etc/yum.repo.d/*.repo /etc/yum.repo.d/repobak
echo -e "[local]\nname=local\nbseurl=file:///mnt/centos7\ngpgcheck=0" >/etc/yum.repo.d/localyum.repo
}
vmware(){
cd /root/packages/vmware
rpm -ivh *.rpm
chmod 777 ./*.bundle
./*.bundle
}
cherry(){
cd /root/packages/cherrytree
rpm -ivh *.rpm
}
ntfs(){
yum install ntfs-3g
}
qstardict(){
cd /root/packages/qstardict
mkdir /usr/share/stardict/
cp -r dic /usr/share/stardict
rpm -ivh *.rpm
}
commod(){
yum repolist|tail -1|awk -F "," '{print $2}'
}
echo -e "正在检查您的yum软件源"
if [[ $commod = 0 ]];then
echo "您的软件源尚未配置，是否需要配置yum源？"
read -p "是 请输入y，否 请输入n" ifyum
case $ifyum in 
y) yumrepolist ;;
n) echo "警告：取消yum配置，您的一些操作可能会出现错误" ;;
esac
else echo "yum源检查正常"
fi
echo -e "请输入要安装的软件集序号\n1 vmware(虚拟机)\n2 CherryTree\n3 ntfs-3g\n4 stardic\n"
read packnum
case $packnum
1) vmware ;;
2) cherry ;;
3) ntfs ;;
4) qstardict ;;
esac
echo "软件集安装成功，程序退出"
