# executing commands as root; saving file in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget ftp://195.220.108.108/linux/fedora/linux/releases/25/Everything/x86_64/os/Packages/v/vim-common-7.4.1989-2.fc25.x86_64.rpm
EOF
