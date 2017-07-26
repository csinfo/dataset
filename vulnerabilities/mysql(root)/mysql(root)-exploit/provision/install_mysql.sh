# uninstall mariadb
sudo dnf remove -y mariadb

cd /home/vagrant
wget https://downloads.mysql.com/archives/get/file/MySQL-5.5.51-1.el7.x86_64.rpm-bundle.tar 
tar xvf MySQL-*.rpm-bundle.tar

# resolve dependency issues 
#sudo dnf install -y libnuma.so.1 mecab mecab-ipadic perl-Memoize perl-Time-Hires
sudo dnf install -y libncurses.so.5 libtinfo.so.5 

# install mysql
sudo rpm -ivh MySQL-*.rpm

#starting mysql 
# sudo service mysql start 

