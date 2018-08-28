#!/bin/nash
read -p "请输入文件名：" filetype
[ -e $filetype ]
if [ $? -eq 0 ]
then
[ -b $filetype ]
	if [ $? -eq 0 ]
	  then
	    echo " $filetype 文件是块设备文件"
	elif [ -L $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是软链接文件"
	elif [ -c $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是字符设备文件"
	elif [ -d $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是目录文件"
	elif [ -f $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是普通文件"
	elif [ -p $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是管道文件"
	elif [ -S $filetype  ];[ $? -eq 0 ]
	  then
	    echo " $filetype 文件是套接字文件"
	else
	echo "该文件不存在"
	fi
else
	echo "该文件不存在"
fi
	
