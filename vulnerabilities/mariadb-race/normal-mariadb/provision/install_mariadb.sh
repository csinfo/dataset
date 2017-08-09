# uninstall mariadb in case it has the latest version since we are exploiting an older version
sudo dnf remove -y mariadb

# download mariaDB
cd /home/vagrant
wget -r --no-parent -nH -nd -np -R index.html* http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-10.1.17/yum/fedora24-amd64/rpms/ 

# resolve dependency issues before install older version of marinaDB
sudo dnf install -y libthrift-0.9.1.so libodbc.so.2 libJudy.so.1 jemalloc perl-Time-HiRes perl-DBI perl-Memoize galera

# install the older version of MarinaDB 10.1.17
sudo rpm -ivh MariaDB-*
# start marinaDB
sudo systemctl start mysql

# setting mariadb and give the root its root passwd (the root user is called 'root')
printf '\ny\nvagrant\nvagrant\ny\ny\ny\ny' | mysql_secure_installation

# now after the last command, marinaDB will be running

