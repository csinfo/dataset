# sudo nmcli connection reload
# sudo systemctl restart network.service

# export provenance data
sudo cp /tmp/audit.log /vagrant/prov-data/
#cp /tmp/camflow.clg /vagrant/prov-data/


# /vagrant/provision/export-final-log.sh &