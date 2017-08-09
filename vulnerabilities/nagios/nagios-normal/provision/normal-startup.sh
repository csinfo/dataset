# removing the error log file to let it be created by the nagios daemon on the next startup 
sudo rm /usr/local/nagios/var/nagios.log 


# start tracking nagios daemon 
sudo camflow --track-file /etc/rc.d/init.d/nagios propagate

# simulate the normal restart of nagios program by the sysadmin 
sudo systemctl restart nagios

sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30

# export log 
cp /tmp/audit.log /vagrant/prov-data/nagios-normal-data.log
