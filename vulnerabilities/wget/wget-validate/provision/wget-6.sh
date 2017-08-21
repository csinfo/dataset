# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/w/w3c-libwww-apps-5.4.1-0.27.20060206cvs.fc24.x86_64.rpm
EOF
