# change to file based logging 
sudo sed -i 's#log-error=/var/log/mysqld.log#log_error=/var/lib/mysql/error.log#g' /etc/my.cnf
sudo systemctl restart mysql
sudo systemctl stop mysql

#remount tmp
sudo mount -o remount,suid /tmp  

#config camflow 
sudo camflow --track-file /usr/bin/mysqld_safe propagate

# simulate how the mysqld_safe wrapper starts mysql
sudo systemctl start mysql 

# wait for mysql to get fully started
sleep 10

# stop camflow capturing 
sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30
#export log
cp /tmp/audit.log /vagrant/prov-data/percona-root-normal-data.log
