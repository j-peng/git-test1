#!/usr/bin/expect
# This is expect test
set timeout 30
spawn  su - user2
expect "密码："
send "user2\n"
expect "$"
send "bash /tmp/1.sh\n"
expect eof
