# executing commands as root; saving file in /root
sudo su - root<<'EOF'
cd /root
wget ftp://rpmfind.net/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/h/httpd-2.4.23-4.fc25.x86_64.rpm
EOF
