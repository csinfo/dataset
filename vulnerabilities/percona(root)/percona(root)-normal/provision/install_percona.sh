# uninstall mariadb and mysql if exist 
sudo dnf remove -y mariadb
sudo dnf remove -y mysql


cd /home/vagrant
wget https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.32-78.0/binary/redhat/7/x86_64/Percona-Server-5.6.32-78.0-r8a8e016-el7-x86_64-bundle.tar

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
sudo rpm -ivh *.rpm

#starting mysql 
sudo service mysql start 

