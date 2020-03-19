#!/bin/bash
# by jpengwu 20200317
# for CentOS 7
mkdir -p /usr/src/install.sh/
cd /usr/src/install.sh/

install_log=/QWdata/website-info.log

echo "will be installed, wait ..."


####---- install dependencies ----begin####
sed -i 's/^exclude/#exclude/' /etc/yum.conf
yum makecache
yum -y remove mysql MySQL-python perl-DBD-MySQL dovecot exim qt-MySQL perl-DBD-MySQL dovecot qt-MySQL mysql-server mysql-connector-odbc php-mysql mysql-bench libdbi-dbd-mysql mysql-devel-5.0.77-3.el5 httpd php mod_auth_mysql mailman squirrelmail php-pdo php-common php-mbstring php-cli &> /dev/null

yum -y install gcc gcc-c++ gcc-g77 make libtool autoconf patch unzip automake libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl libmcrypt libmcrypt-devel libpng libpng-devel libjpeg-devel openssl openssl-devel curl curl-devel libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl autoconf automake libaio* openssl-devel gd gd-devel geoip geoip-devel python3 git perl perl-devel perl-ExtUtils-Embed gmake
pip uninstall coscmd
pip3 install coscmd
cat > ~/.cos.conf <<END
[common]
secret_id = AKIDTvMdnVOAvCIEZ6fp0LVb8at4AEf7xM3f
secret_key = 0HrGp7fGVbMz2rPm3tVzORJ4YxIVm6MR 
bucket = backup-1255864481
region = ap-guangzhou
max_thread = 5
part_size = 1
schema = https
verify = md5
anonymous = False
END

iptables -F
####---- install dependencies ----end####


####---- install software ----begin####
rm -f tmp.log
echo tmp.log

## set_sysclt
\cp /etc/sysctl.conf /etc/sysctl.conf.bak

sed -i 's/net\.ipv4\.tcp_syncookies.*/net\.ipv4\.tcp_syncookies = 1/' /etc/sysctl.conf

if cat /etc/sysctl.conf | grep "aliyun web add" > /dev/null ;then
echo ""
else
cat >> /etc/sysctl.conf <<EOF

fs.file-max=65535
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 5
net.ipv4.tcp_syn_retries = 5
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 30
#net.ipv4.tcp_keepalive_time = 120
net.ipv4.ip_local_port_range = 1024  65535
kernel.shmall = 2097152
kernel.shmmax = 2147483648
kernel.shmmni = 4096
kernel.sem = 5010 641280 5010 128
net.core.wmem_default=262144
net.core.wmem_max=262144
net.core.rmem_default=4194304
net.core.rmem_max=4194304
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_keepalive_time = 30
net.ipv4.tcp_window_scaling = 0
net.ipv4.tcp_sack = 0
kernel.hung_task_timeout_secs = 0
EOF
fi
sysctl -p

## set_ulimit
if cat /etc/security/limits.conf | grep "* soft nofile 65535" > /dev/null;then
        echo ""
else
        echo "* soft nofile 65535" >> /etc/security/limits.conf
fi

if cat /etc/security/limits.conf | grep "* hard nofile 65535" > /dev/null ;then
        echo ""
else
        echo "* hard nofile 65535" >> /etc/security/limits.conf
fi

## install_dir
userdel www
groupadd www
useradd -g www -M -d /QWdata/www -s /usr/sbin/nologin www &> /dev/null
mkdir -p /QWdata
mkdir -p /QWdata/server
mkdir -p /QWdata/server/mongodb
mkdir -p /QWdata/www
mkdir -p /QWdata/www/phpwind
mkdir -p /QWdata/log
mkdir -p /QWdata/log/php
mkdir -p /QWdata/log/mysql
mkdir -p /QWdata/log/openresty
chown -R www:www /QWdata/log
mkdir -p /QWdata/server/mysql_5.6
ln -s /QWdata/server/mysql_5.6 /QWdata/server/mysql
mkdir -p /QWdata/server/php_7.2
ln -s /QWdata/server/php_7.2 /QWdata/server/php
echo "---------- make dir ok ----------" >> tmp.log

## install_env.sh
CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ ! -f libiconv-1.13.1.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/libiconv-1.13.1.tar.gz
fi
rm -rf libiconv-1.13.1
tar -zxf libiconv-1.13.1.tar.gz
cd libiconv-1.13.1
./configure --prefix=/usr/local
make -j$CPU_NUM
make install
cd ..

if [ ! -f zlib-1.2.3.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/zlib-1.2.3.tar.gz
fi
rm -rf zlib-1.2.3
tar -zxf zlib-1.2.3.tar.gz
cd zlib-1.2.3
./configure
make CFLAGS=-fpic -j$CPU_NUM
make install
cd ..

if [ ! -f freetype-2.1.10.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/freetype-2.1.10.tar.gz
fi
rm -rf freetype-2.1.10
tar -zxf freetype-2.1.10.tar.gz
cd freetype-2.1.10
./configure --prefix=/usr/local/freetype.2.1.10
make -j$CPU_NUM
make install
cd ..

if [ ! -f libpng-1.2.50.tar.gz ];then
    wget http://oss.aliyuncs.com/aliyunecs/onekey/libpng-1.2.50.tar.gz
fi
rm -rf libpng-1.2.50
tar -zxf libpng-1.2.50.tar.gz
cd libpng-1.2.50
./configure --prefix=/usr/local/libpng.1.2.50
make CFLAGS=-fpic -j$CPU_NUM
make install
cd ..

if [ ! -f libevent-1.4.14b.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/libevent-1.4.14b.tar.gz
fi
rm -rf libevent-1.4.14b
tar -zxf libevent-1.4.14b.tar.gz
cd libevent-1.4.14b
./configure
make -j$CPU_NUM
make install
cd ..

if [ ! -f libmcrypt-2.5.8.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/libmcrypt-2.5.8.tar.gz
fi
rm -rf libmcrypt-2.5.8
tar -zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --disable-posix-threads
make -j$CPU_NUM
make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make
make install
cd ../..

if [ ! -f pcre-8.12.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/pcre-8.12.tar.gz
fi
rm -rf pcre-8.12
tar -zxf pcre-8.12.tar.gz
cd pcre-8.12
./configure
make -j$CPU_NUM
make install
cd ..

if [ ! -f libiconv-1.13.1.tar.gz ];then
	coscmd download temp/libiconv-1.13.1.tar.gz ./
fi
tar -zxf libiconv-1.13.1.tar.gz
cd libiconv-1.13.1
./configure --prefix=/usr/local/libiconv
make
make install

if [ ! -f jpegsrc.v6b.tar.gz ];then
        wget http://oss.aliyuncs.com/aliyunecs/onekey/jpegsrc.v6b.tar.gz
fi
rm -rf jpeg-6b
tar -zxf jpegsrc.v6b.tar.gz
cd jpeg-6b
if [ -e /usr/share/libtool/config.guess ];then
cp -f /usr/share/libtool/config.guess .
elif [ -e /usr/share/libtool/config/config.guess ];then
cp -f /usr/share/libtool/config/config.guess .
fi
if [ -e /usr/share/libtool/config.sub ];then
cp -f /usr/share/libtool/config.sub .
elif [ -e /usr/share/libtool/config/config.sub ];then
cp -f /usr/share/libtool/config/config.sub .
fi
./configure --prefix=/usr/local/jpeg.6 --enable-shared --enable-static
mkdir -p /usr/local/jpeg.6/include
mkdir /usr/local/jpeg.6/lib
mkdir /usr/local/jpeg.6/bin
mkdir -p /usr/local/jpeg.6/man/man1
make -j$CPU_NUM
make install-lib
make install
cd ..

#load /usr/local/lib .so
touch /etc/ld.so.conf.d/usrlib.conf
echo "/usr/local/lib" > /etc/ld.so.conf.d/usrlib.conf
/sbin/ldconfig

echo "---------- env ok ----------" >> tmp.log

## install_mysql_5.6
rm -rf mysql-5.6.21-linux-glibc2.5-x86_64
if [ ! -f mysql-5.6.21-linux-glibc2.5-x86_64.tar.gz ];then
  wget http://zy-res.oss-cn-hangzhou.aliyuncs.com/mysql/mysql-5.6.21-linux-glibc2.5-x86_64.tar.gz
fi
echo "decompression mysql source"
tar -xzf mysql-5.6.21-linux-glibc2.5-x86_64.tar.gz
mv mysql-5.6.21-linux-glibc2.5-x86_64/* /QWdata/server/mysql
groupadd mysql
useradd -g mysql -s /sbin/nologin mysql
/QWdata/server/mysql/scripts/mysql_install_db --datadir=/QWdata/server/mysql/data/ --basedir=/QWdata/server/mysql --user=mysql
chown -R mysql:mysql /QWdata/server/mysql/
chown -R mysql:mysql /QWdata/server/mysql/data/
chown -R mysql:mysql /QWdata/log/mysql
\cp -f /QWdata/server/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -i 's#^basedir=$#basedir=/QWdata/server/mysql#' /etc/init.d/mysqld
sed -i 's#^datadir=$#datadir=/QWdata/server/mysql/data#' /etc/init.d/mysqld

cat > /etc/my.cnf <<END
[client]
port            = 3306
socket          = /tmp/mysql.sock
[mysqld]
port            = 3306
socket          = /tmp/mysql.sock
skip-external-locking
log-error=/QWdata/log/mysql/error.log
key_buffer_size = 16M
max_allowed_packet = 1M
table_open_cache = 64
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M

log-bin=mysql-bin
binlog_format=mixed
server-id       = 1

sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout
END

chmod 755 /etc/init.d/mysqld
/etc/init.d/mysqld start
echo "---------- mysql_5.6 ok ----------" >> tmp.log

##install mongodb
if [ ! -f mongodb-linux-x86_64-3.6.17.tgz ];then
  coscmd download temp/mongodb-linux-x86_64-3.6.17.tgz ./
fi
echo "decompression mongodb source\n"
tar -zxf mongodb-linux-x86_64-3.6.17.tgz
mv mongodb-linux-x86_64-3.6.17/* /QWdata/server/mongodb 
mkdir -p /QWdata/server/mongodb/data/db
mkdir -p /QWdata/server/mongodb/data/log
touch /QWdata/server/mongodb/data/log/logs.log
echo "---------- mongodb ok ----------" >> tmp.log


## install PHP_7.2
rm -rf php-7.2.28
if [ ! -f php-7.2.28.tar.gz ];then
  coscmd download temp/php-7.2.28.tar.gz ./
fi
echo "decompression php source\n"
tar -zxf php-7.2.28.tar.gz
cd php-7.2.28
./configure --prefix=/QWdata/server/php \
--enable-opcache \
--with-config-file-path=/QWdata/server/php/etc \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--enable-fpm \
--enable-fastcgi \
--enable-static \
--enable-inline-optimization \
--enable-sockets \
--enable-wddx \
--enable-zip \
--enable-calendar \
--enable-bcmath \
--enable-soap \
--with-zlib \
--with-iconv \
--with-gd \
--with-xmlrpc \
--enable-mbstring \
--without-sqlite \
--with-curl \
--enable-ftp \
--with-mcrypt  \
--with-freetype-dir=/usr/local/freetype.2.1.10 \
--with-jpeg-dir=/usr/local/jpeg.6 \
--with-png-dir=/usr/local/libpng.1.2.50 \
--with-iconv=/usr/local/libiconv \
--disable-ipv6 \
--disable-debug \
--with-openssl \
--disable-maintainer-zts \
--disable-safe-mode \
--disable-fileinfo

make -j$CPU_NUM
make install
cd ..
coscmd download temp/php.ini /QWdata/server/php/etc/php.ini

#adjust php.ini
sed -i 's/post_max_size = 8M/post_max_size = 64M/g' /QWdata/server/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /QWdata/server/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /QWdata/server/php/etc/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /QWdata/server/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /QWdata/server/php/etc/php.ini
#adjust php-fpm
cp /QWdata/server/php/etc/php-fpm.conf.default /QWdata/server/php/etc/php-fpm.conf
sed -i 's,user = nobody,user=www,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,group = nobody,group=www,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,^pm.min_spare_servers = 1,pm.min_spare_servers = 5,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,^pm.max_spare_servers = 3,pm.max_spare_servers = 35,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,^pm.max_children = 5,pm.max_children = 100,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,^pm.start_servers = 2,pm.start_servers = 20,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,;pid = run/php-fpm.pid,pid = run/php-fpm.pid,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,;error_log = log/php-fpm.log,error_log = /QWdata/log/php/php-fpm.log,g'   /QWdata/server/php/etc/php-fpm.conf
sed -i 's,;slowlog = log/$pool.log.slow,slowlog = /QWdata/log/php/\$pool.log.slow,g'   /QWdata/server/php/etc/php-fpm.conf
#self start
install -v -m755 ./php-7.2.28/sapi/fpm/init.d.php-fpm  /etc/init.d/php-fpm

/QWdata/server/php/bin/pecl install redis
/QWdata/server/php/bin/pecl install swoole
/QWdata/server/php/bin/pecl install mongodb

echo "extension=mongodb.so" >> /QWdata/server/php/etc/php.ini
echo "extension=swoole.so" >> /QWdata/server/php/etc/php.ini
echo "extension=redis.so" >> /QWdata/server/php/etc/php.ini
echo "log_errors = On" >> /QWdata/server/php/etc/php.ini

echo "catch_workers_output = yes" >> /QWdata/server/php/etc/php-fpm.conf

cp /QWdata/server/php/etc/php-fpm.d/www.conf.default /QWdata/server/php/etc/php-fpm.d/www.conf
sed -i 's/user\ =\ nobody/user\ =\ www/g' /QWdata/server/php/etc/php-fpm.d/www.conf
sed -i 's/group\ =\ nobody/group\ =\ www/g' /QWdata/server/php/etc/php-fpm.d/www.conf

sleep 5
/etc/init.d/php-fpm start
echo "---------- php_7.2 ok ----------" >> tmp.log

## install php_extension


## install openresty_1.13
coscmd download temp/openresty-1.13.6.2.tar.gz /QWdata/server/
tar -zxf /QWdata/server/openresty-1.13.6.2.tar.gz
cd openresty-1.13.6.2
./configure --prefix=/QWdata/server/openresty --user=www --group=www --with-http_v2_module --with-http_stub_status_module --without-http-cache --with-http_ssl_module --with-http_gzip_static_module  --with-pcre --with-ipv6 --with-http_image_filter_module --with-mail --with-mail_ssl_module --with-md5= --with-sha1= --with-debug --with-http_perl_module --with-http_geoip_module --with-http_mp4_module --with-http_gunzip_module --with-http_flv_module --with-http_realip_module --with-luajit --with-http_realip_module  --with-stream --with-stream_ssl_module --with-stream --with-stream_ssl_preread_module
gmake -j $CPU_NUM
gmake install
coscmd download temp/vhosts.tar.gz ./
tar -zxf vhosts.tar.gz -C /QWdata/server/openresty/nginx/
sed -i 's#/alidata/server/nginx/conf/rewrite/phpwind.conf#/QWdata/server/openresty/nginx/conf/rewrite/phpwind.conf#g' /QWdata/server/openresty/nginx/conf/vhosts/*.conf
sed -i 's/alidata/QWdata/g'  /QWdata/server/openresty/nginx/conf/*.conf

cat > /QWdata/server/openresty/nginx/html/info.php << EOF
<?php
  phpinfo();
EOF

rm -rf /QWdata/server/openresty-1.13.6.2.tar.gz
chown -R www.www /QWdata/server/*
echo "---------- install openresty_1.13  ok ----------" >> tmp.log
####---- install software ----end####


####---- Start command is written to the rc.local ----begin####
echo "/etc/init.d/mysqld start" >> /etc/rc.local
echo "/etc/init.d/php-fpm start" >> /etc/rc.local
echo "/QWdata/server/openresty/nginx/sbin/nginx" >> /etc/rc.local
echo "/QWdata/server/mongodb/bin/mongod --dbpath=/QWdata/server/mongodb/data/db --logpath=/QWdata/server/mongodb/data/log/logs.log --logappend --fork" >> /etc/rc.local
####---- Start command is written to the rc.local ----end####

sed -i 's/^#exclude/exclude/' /etc/yum.conf

####---- mysql password initialization ----begin####
echo "---------- rc init ok ----------" >> tmp.log

echo "---------- mysql init ok ----------" >> tmp.log
####---- mysql password initialization ----end####

####---- Environment variable settings ----begin####
\cp /etc/profile /etc/profile.bak
echo 'export PATH=$PATH:/QWdata/server/mysql/bin:/QWdata/server/openresty/nginx/sbin:/QWdata/server/php/sbin:/QWdata/server/php/bin:/QWdata/server/mongodb/bin' >> /etc/profile
export PATH=$PATH:/QWdata/server/mysql/bin:/QWdata/server/openrsty/nginx/sbin:/QWdata/server/php/sbin:/QWdata/server/php/bin:/QWdata/server/mongodb/bin
####---- Environment variable settings ----end####

####---- restart ----begin####
/etc/init.d/php-fpm restart > /dev/null
/QWdata/server/openresty/nginx/sbin/nginx
/QWdata/server/mongodb/bin/mongod --dbpath=/QWdata/server/mongodb/data/db --logpath=/QWdata/server/mongodb/data/log/logs.log --logappend --fork
####---- restart ----end####

####---- log ----begin####
\cp tmp.log $install_log
cat $install_log
####---- log ----end####
source /etc/profile
