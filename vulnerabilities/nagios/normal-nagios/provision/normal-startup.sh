# removing the error log file to let it be created by the nagios daemon on the next startup 
sudo rm /usr/local/nagios/var/nagios.log 


# start tracking nagios daemon 
sudo camflow --track-file /etc/rc.d/init.d/nagios propagate

# simulate the normal restart of nagios program by the sysadmin 
sudo systemctl restart nagios

# disable camflow to disregard uneccessary provenance data
sleep 20s
sudo camflow -e false

# give camflow some time to write to audit.log
sleep 60 

# export log 
cp /tmp/audit.log /vagrant/prov-data/audit.log
