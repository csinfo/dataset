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

# wait for mysql to get fully started
sleep 10

# stop camflow capturing 
sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30
# #export log
cp /tmp/audit.log /vagrant/prov-data/mariadb-root-normal-data.log

