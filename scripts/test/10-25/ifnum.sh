#!/bin/bash
#
 read -p "please input a num:" numa
 read -p "please input another num:" numb
$numc=$[$numa + $numb ]
 [ $numc -gt 100 ]
if [ $? -eq 0 ]
 then
      echo "no"
 else
       echo "yes"
 fi
