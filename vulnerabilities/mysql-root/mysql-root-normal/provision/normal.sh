# set selinux to be permissive
sudo setenforce 0

#remount tmp
sudo mount -o remount,suid /tmp

#config camflow
sudo camflow --track-file /usr/bin/mysqld_safe propagate

#starting mysql
sudo systemctl start mysql

#wait for mysql to get fully started
sleep 10

# stop camflow capturing
sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30
#export log
# cp /tmp/audit.log /vagrant/prov-data/mysql-root-normal-data.log
