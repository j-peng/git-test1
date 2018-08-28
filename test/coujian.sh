#!/bin/bash
echo "input"
while read coujian
do
    echo -e "`echo $coujian`\t`echo $[ $RANDOM %99+1 ]`" &>/tmp/cj.txt
    tail -1 /tmp/cj.txt
done
