# wgetting as root
sudo -s <<'EOF'
cd /root
wget http://www.google.com 
sleep 5
wget http://www.cnn.com  
sleep 5
wget http://www.yahoo.com
sleep 5  
wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/v/vim-common-7.4.1989-2.fc25.x86_64.rpm
sleep 5
wget ftp://fr.rpmfind.net/linux/fedora/linux/updates/25/x86_64/l/lynx-2.8.9-0.14.dev11.fc25.x86_64.rpm 
sleep 5
wget -N http://192.168.33.8/database.db > /dev/null 2>&1
sleep 5
wget -N http://192.168.33.8/database.db > /dev/null 2>&1
sleep 5
rm .wgetrc
sleep 5
wget http://www.apple.com  
sleep 5
wget http://www.facebook.com  
sleep 5
wget http://www.twitter.com 
sleep 5 
wget ftp://rpmfind.net/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/h/httpd-2.4.23-4.fc25.x86_64.rpm
sleep 5  
wget ftp://rpmfind.net/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/p/php-7.0.12-2.fc25.x86_64.rpm
EOF

