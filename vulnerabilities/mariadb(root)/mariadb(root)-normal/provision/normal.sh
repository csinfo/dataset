# change to file-based logging
sudo cat<<EOF>>/etc/my.cnf 
[mysqld]
log-error=/var/lib/mysql/error.log
EOF

#remount tmp
sudo mount -o remount,suid /tmp 

# #config camflow 
sudo camflow --track-file /usr/bin/mysqld_safe propagate

# simulate normal behavior 
sudo -u root /usr/bin/mysqld_safe start &

sleep 45
# #export log
cp /tmp/audit.log /vagrant/prov-data/audit.log

