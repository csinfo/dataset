cd /home/vagrant
# download lynx browser for testing
sudo dnf install -y lynx #for dubugging purposes only 

# install apache http server
sudo dnf install -y httpd
# start http damon
sudo systemctl start httpd.service
# make sure the next time it will start automatically after reboot
sudo systemctl enable httpd.service 

# install php 
sudo dnf install -y php php-pdo_mysql
# restart http to have php
sudo systemctl restart httpd.service 

# setting up firewall to allow http and https traffic 
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
 
