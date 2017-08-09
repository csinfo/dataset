# sudo nmcli connection reload
# sudo systemctl restart network.service

# stop camflow capturing 
sleep 5
sudo camflow -e false
# wait a while so that relay fs writes all the data to audit.log
sleep 30

# export provenance data
sudo cp /tmp/audit.log /vagrant/prov-data/
#cp /tmp/camflow.clg /vagrant/prov-data/


# /vagrant/provision/export-final-log.sh &
