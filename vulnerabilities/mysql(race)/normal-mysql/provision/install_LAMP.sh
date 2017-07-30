cd /home/vagrant
sudo dnf install -y lynx #for dubugging purposes only 

#install apache
sudo dnf install -y httpd 
sudo systemctl start httpd.service
sudo systemctl enable httpd.service 

#install MySQL (MariaDB)
# sudo dnf install -y mariadb-server mariadb 
# sudo systemctl start mariadb 
# printf '\ny\nvagrant\nvagrant\ny\ny\ny\ny' | mysql_secure_installation  #questions asked 
# sudo systemctl enable mariadb.service

#install php 
sudo dnf install -y php php-pdo_mysql
sudo systemctl restart httpd.service 

#setting up firewall to allow http and https traffic 
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
 