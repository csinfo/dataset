cd /usr/share/
sudo wget "ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/w/wget-1.17.1-4.fc24.x86_64.rpm"
sudo dnf install -y wget-1.17.1-4.fc24.x86_64.rpm

cd /etc/cron.d/ 
sudo touch update-database
sudo echo '*/2 * * * * root wget -N http://192.168.33.8/database.db > /dev/null 2>&1' > update-database 
