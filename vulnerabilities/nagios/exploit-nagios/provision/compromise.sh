/vagrant/provision/restart-nagios.sh &
printf "y\n" | sudo su - nagios /vagrant/provision/nagios-root-privesc.sh /usr/local/nagios/var/nagios.log
 