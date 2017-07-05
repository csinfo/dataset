sleep 20
sudo systemctl restart nagios  #simulate how admin restart nagios 
sleep 50
cp /tmp/audit.log /vagrant/prov-data/audit.log
