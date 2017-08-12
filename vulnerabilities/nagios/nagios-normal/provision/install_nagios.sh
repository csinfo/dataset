cd /home/vagrant

#install build dependencies 
sudo dnf install -y gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip

#create nagios user and group
sudo useradd nagios 
sudo groupadd nagcmd 
sudo usermod -a -G nagcmd nagios 

#install nagios core
curl -L -O https://sourceforge.net/projects/nagios/files/nagios-4.x/nagios-4.2.3/nagios-4.2.3.tar.gz
tar xvf nagios-*.tar.gz 
cd nagios-4.2.3

sudo ./configure --with-command-group=nagcmd 
sudo make all 
sudo make install 
sudo make install-commandmode
sudo make install-init
sudo make install-config 
sudo make install-webconf 

sudo usermod -G nagcmd apache

#install plugins
cd /home/vagrant 
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.3.tar.gz 
tar xvf nagios-plugins-*.tar.gz
cd nagios-plugins-* 
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl 
sudo make 
sudo make install 

#install NRPE 
cd /home/vagrant 
curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar xvf nrpe-*.tar.gz 
cd nrpe-2.15
sudo ./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
sudo make all  
sudo make install 
sudo make install-xinetd 
sudo make install-daemon-config

sudo sed -i 's/127.0.0.1/127.0.0.1 192.168.33.10/g' /etc/xinetd.d/nrpe
sudo service xinetd restart 
sudo systemctl restart xinetd.service

# configure nagios
sudo sed -i 's:#cfg_dir=/usr/local/nagios/etc/servers:cfg_dir=/usr/local/nagios/etc/servers:' /usr/local/nagios/etc/nagios.cfg 
sudo mkdir /usr/local/nagios/etc/servers

#skipping configure Nagios Contacts 

#Configure check_nrpe Command 
# sudo cat <<EOF>> /usr/local/nagios/etc/objects/commands.cfg
# define command{
# 	command_name check_nrpe 
# 	command_line \$USER1$/check_nrpe -H \$HOSTADDRESS$ -c \$ARG1$
# }
# EOF 
sudo echo "define command{" >> /usr/local/nagios/etc/objects/commands.cfg
sudo echo "		command_name check_nrpe" >> /usr/local/nagios/etc/objects/commands.cfg
sudo echo " 	command_line \$USER1$/check_nrpe -H \$HOSTADDRESS$ -c \$ARG1$" >> /usr/local/nagios/etc/objects/commands.cfg
sudo echo "}" >> /usr/local/nagios/etc/objects/commands.cfg

#Configure Apache
#sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin #interactive 
sudo dnf install -y expect
/vagrant/provision/expect.sh
sudo service nagios start
sudo systemctl enable nagios
sudo systemctl restart httpd.service 

sudo chkconfig nagios on 

