#!/usr/bin/expect -f
spawn sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin 
expect "New password:"
send "vagrant\r"
expect "password:"
send "vagrant\r"
interact