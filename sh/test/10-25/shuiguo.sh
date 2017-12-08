#!/bin/bash
echo -e "本店商品和价格如下\n\n序号\t水果名\t单价\n1\tapple\t8.6元/500g\n2\tbanana\t3.8元/500g\n3\torange\t6.5元/500g\n4\tplum\t5元/500g\n5\tpeach\t5.8元/500g\n\n"
declare -A fruit
fruit=([apple]=8.6 [banana]=3.8 [orange]=6.5 [plum]=5 [peach]=5.8)



#pldj=5
#pedj=5.8
#echo "请输入要购买的水果序号"
read  sgnum
ecnum (){ echo  水果总价格是 }
case $sgnum in
1)
 ecnum-8.6元;;
2)
 echo "水果总价格是3.8元";;
3)
 echo "水果总价格是6.5元";;
4)
 echo "水果总价格是5元";;
5)
 echo "水果总价格是5.8元";;
12)
 echo "水果总价格是 `echo "8.6 + 3.8"|bc`元";;
13)
 echo "水果总价格是 `echo "8.6 + 6.5"|bc`元";;
14)
 echo "水果总价格是 `echo "8.6 + 5"|bc`元";;
15)
 echo "水果总价格是 `echo "8.6 + 5.8"|bc`元";;
23)
 echo "水果总价格是 `echo "3.8 + 6.5"|bc`元";;
24)
 echo "水果总价格是 `echo "3.8 + 5"|bc`元";;
25)
 echo "水果总价格是 `echo "3.8 + 5.8"|bc`元";;
34)
 echo "水果总价格是 `echo "6.5 + 5"|bc`元";;
35)
 echo "水果总价格是 `echo "6.5 + 5.8"|bc`元";;
123)
 echo "水果总价格是 `echo "8.6 + 3.8 + 6.5"|bc`元";;
124)
 echo "水果总价格是 `echo "8.6 + 3.8 + 5"|bc`元";;
125)
 echo "水果总价格是 `echo "8.6 + 3.8 + 5.8"|bc`元";;
134)
 echo "水果总价格是 `echo "8.6 + 6.5 + 5"|bc`元";;
135)
 echo "水果总价格是 `echo "8.6 + 6.5 + 5.8"|bc`元";;
145)
 echo "水果总价格是 `echo "8.6 + 5 + 5.8"|bc`元";;
1234)
 echo "水果总价格是 `echo "8.6 + 3.8 + 6.5 + 5"|bc`元";;
1235)
 echo "水果总价格是 `echo "8.6 + 3.8 + 6.5 + 5.8"|bc`元";;
1245)
 echo "水果总价格是 `echo "8.6 + 3.8 + 5 + 5.8"|bc`元";;
1345)
 echo "水果总价格是 `echo "8.6 + 6.5 + 5 + 5.8"|bc`元";;
2345)
 echo "水果总价格是 `echo "3.8 + 6.5 + 5 + 5.8"|bc`元";;
12345)
 echo "水果总价格是 `echo "8.6 + 3.8 + 6.5 + 5 + 5.8"|bc`元";;
*)
echo -e "\n输入语法错误\n请按规定语法重新执行脚本进行查询\nUsage :[1|2|12|24|123|134|1234|2345|12345]"
esac
