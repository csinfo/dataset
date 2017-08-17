# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://rpmfind.net/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/p/php-7.0.12-2.fc25.x86_64.rpm
EOF
