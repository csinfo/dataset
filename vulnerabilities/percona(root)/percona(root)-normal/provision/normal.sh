# change to file based logging 
sudo sed -i 's#log-error=/var/log/mysqld.log#log_error=/var/lib/mysql/error.log#g' /etc/my.cnf
sudo systemctl restart mysql

#remount tmp
sudo mount -o remount,suid /tmp  

#config camflow 
sudo camflow --track-file /usr/bin/mysqld_safe propagate

# simulate how the mysqld_safe wrapper restarts mysql
sudo systemctl restart mysql

#export log
cp /tmp/audit.log /vagrant/prov-data/audit.log