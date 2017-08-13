# uninstall mariadb
sudo dnf remove -y mariadb

cd /home/vagrant
wget https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.32-78.0/binary/redhat/7/x86_64/Percona-Server-5.6.32-78.0-r8a8e016-el7-x86_64-bundle.tar
# solving dependency issues
wget ftp://rpmfind.net/linux/fedora/linux/releases/26/Everything/x86_64/os/Packages/n/ncurses-compat-libs-6.0-8.20170212.fc26.x86_64.rpm
sudo dnf install -y ncurses-compat-libs-6.0-8.20170212.fc26.x86_64.rpm
# sudo dnf install -y libreadline.so.6
wget ftp://rpmfind.net/linux/fedora/linux/releases/26/Everything/x86_64/os/Packages/c/compat-readline6-6.3-11.fc26.x86_64.rpm
sudo dnf install -y compat-readline6-6.3-11.fc26.x86_64.rpm

# untar
tar xvf Percona-Server-5.6.32-78.0*.tar

# resolve dependency issues
sudo dnf install -y libnuma.so.1 
sudo dnf install -y libncurses.so.5
sudo dnf install -y perl-Time-HiRes
sudo dnf install -y perl-Test-Simple
sudo dnf install -y jemalloc

# install percona
#sudo rpm -ivh Percona-Server-server-*.rpm Percona-Server-client-*.rpm Percona-Server-shared-*.rpm
sudo rpm -ivh Percona*.rpm

#starting mysql 
sudo service mysql start 

