# uninstall mariadb, from LAMP
sudo dnf remove -y mariadb

# download mariadb 
cd /home/vagrant
wget -r --no-parent -nH -nd -np -R index.html* http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-10.1.17/yum/fedora24-amd64/rpms/ 

# resolve dependency issues
sudo dnf install -y libthrift-0.9.1.so libodbc.so.2 libJudy.so.1 jemalloc perl-Time-HiRes perl-DBI perl-Memoize galera

sudo rpm -ivh MariaDB-*
# start 
sudo systemctl start mysql

# setting mariadb and root passwd
printf '\ny\nvagrant\nvagrant\ny\ny\ny\ny' | mysql_secure_installation 

