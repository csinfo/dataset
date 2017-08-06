sudo rm -rf /usr/bin/camflow-config
sudo dnf install -y zlib-devel
cd /home/vagrant
sudo git clone https://github.com/camflow/camflow-config 
cd camflow-config 
sudo git checkout dev
make prepare && make all && make install 
cd /etc/systemd/system/ 

