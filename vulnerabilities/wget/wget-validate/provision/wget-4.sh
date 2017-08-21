# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/h/httpd-filesystem-2.4.18-2.fc24.noarch.rpm
EOF
