# set selinux to be permissive
sudo setenforce 0 

#remount tmp
sudo mount -o remount,suid /tmp  

#config camflow 
sudo camflow --track-file /usr/bin/mysqld_safe propagate
 
sudo systemctl start mysql

#export log
cp /tmp/audit.log /vagrant/prov-data/audit.log
