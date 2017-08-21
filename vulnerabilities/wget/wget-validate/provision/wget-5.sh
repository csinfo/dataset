# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libfabric-devel-1.3.0-1.fc24.i686.rpm
EOF
