# executing commands as root; saving index.html in /root
sudo camflow --track-file /usr/bin/wget propagate
sudo su - root<<'EOF'
cd /root
wget http://www.cnn.com
EOF
