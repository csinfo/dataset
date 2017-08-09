# uninstall mariadb, from LAMP
sudo dnf remove -y mariadb
sudo dnf remove -y mysql

# download mariadb 
cd /home/vagrant
# wget -r --no-parent -nH -nd -np -R index.html* http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-10.1.17/yum/fedora24-amd64/rpms/ 
wget -r --no-parent -nH -nd -np -R index.html* http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-10.1.10/yum/fedora23-amd64/rpms/

# resolve dependency issues
sudo dnf install -y libthrift-0.9.1.so libodbc.so.2 libJudy.so.1 jemalloc perl-Time-HiRes perl-DBI perl-Memoize galera
sudo dnf install -y libncurses.so.5 

wget ftp://195.220.108.108/linux/fedora/linux/releases/23/Everything/x86_64/os/Packages/j/jemalloc-3.6.0-9.fc23.x86_64.rpm
sudo dnf install -y jemalloc-*.rpm 

sudo rpm -ivh MariaDB-*
# start 
# sudo systemctl start mysql

# setting mariadb and root passwd
# printf '\ny\nvagrant\nvagrant\ny\ny\ny\ny' | mysql_secure_installation 

