# stop camflow capturing 
sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30
cp /tmp/audit.log /vagrant/prov-data/mysql-race-normal-data.log
