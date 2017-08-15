# ** SAME AS install_mariadb.sh IN NORMAL BEHAVIOR **
# uninstall mariadb, from LAMP
sudo dnf remove -y mariadb

# download mariadb 
cd /home/vagrant
wget -r --no-parent -nH -nd -np -R index.html* http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-10.1.17/yum/fedora24-amd64/rpms/ 
wget ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/t/thrift-0.9.1-17.fc24.3.x86_64.rpm
wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/u/unixODBC-2.3.4-2.fc24.x86_64.rpm
wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/j/Judy-1.0.5-12.fc24.x86_64.rpm
# resolve dependency issues
# sudo dnf install -y libthrift-0.9.1.so libodbc.so.2 libJudy.so.1 jemalloc perl-Time-HiRes perl-DBI perl-Memoize galera
sudo dnf install -y jemalloc perl-Time-HiRes perl-DBI perl-Memoize galera
sudo dnf install -y thrift-0.9.1-17.fc24.3.x86_64.rpm unixODBC-2.3.4-2.fc24.x86_64.rpm Judy-1.0.5-12.fc24.x86_64.rpm

sudo rpm -ivh MariaDB-*
# start 

# setting selinux to be permissive, otherwise, we would have gotten the following errors: 
# selinux is preventing mysqld from read access on the file plugin.frm
# selinux is preventing mysqld from write access on the directory /var/lib/mysql 
setenforce 0 
# sudo systemctl start mysql

# setting mariadb and root passwd
# printf '\ny\nvagrant\nvagrant\ny\ny\ny\ny' | mysql_secure_installation 

