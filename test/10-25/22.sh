 #!/bin/bash
 read -p "请输入要查询的参数" cjfs
 [ $cjfs -le 100 ]
 if [ $? -eq 0 ]
 then
  [ $cjfs -lt 60 ]
    if [ $? -eq 0 ]
     then
      echo "您所查询的成绩范围是：差 "
    elif [ $cjfs -lt 80 ];[ $? -eq 0 ]
     then
      echo "您所查询的成绩范围是：良"
    elif [ $cjfs -le 101 ];[ $? -eq 0 ]
     then
      echo "您所查询的成绩范围是：优"
     fi
 else
  echo "分数不合法"
 fi
