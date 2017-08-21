# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/i/ImageMagick-c++-devel-6.9.3.0-2.fc24.x86_64.rpm
EOF
