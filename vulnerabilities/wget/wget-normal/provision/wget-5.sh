# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://fr.rpmfind.net/linux/fedora/linux/updates/25/x86_64/l/lynx-2.8.9-0.14.dev11.fc25.x86_64.rpm
EOF
