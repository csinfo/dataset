sudo systemctl disable firewalld
sudo systemctl stop firewalld 

cd /usr/share/
sudo wget "ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/w/wget-1.17.1-4.fc24.x86_64.rpm"
sudo dnf install -y wget-1.17.1-4.fc24.x86_64.rpm

cd /etc/cron.d/
sudo touch update-database
sudo cat<<_EOF_>>update-database
* * * * * root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 5; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 10; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 15; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 20; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 25; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 30; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 35; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 40; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 45; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 50; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
* * * * * sleep 55; root wget -N http://192.168.33.8/database.db > /dev/null 2>&1
_EOF_
