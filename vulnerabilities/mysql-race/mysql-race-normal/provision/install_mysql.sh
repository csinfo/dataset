# uninstall mariadb
sudo dnf remove -y mariadb

cd /home/vagrant
wget https://downloads.mysql.com/archives/get/file/MySQL-5.5.51-1.el7.x86_64.rpm-bundle.tar 
tar xvf MySQL-*.rpm-bundle.tar

# resolve dependency issues 
#sudo dnf install -y libnuma.so.1 mecab mecab-ipadic perl-Memoize perl-Time-Hires

# sudo dnf install -y libncurses.so.5 libtinfo.so.5 

# wget ftp://rpmfind.net/linux/fedora/linux/releases/23/Everything/x86_64/os/Packages/n/ncurses-base-5.9-21.20150214.fc23.noarch.rpm
# sudo dnf install -y ncurses-base-5.9-21.20150214.fc23.noarch.rpm

# wget ftp://rpmfind.net/linux/fedora/linux/releases/23/Everything/x86_64/os/Packages/n/ncurses-libs-5.9-21.20150214.fc23.i686.rpm
# sudo dnf install -y ncurses-libs-5.9-21.20150214.fc23.i686.rpm

# wget ftp://rpmfind.net/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/n/ncurses-compat-libs-6.0-5.20160116.fc24.i686.rpm

# wget http://invisible-mirror.net/archives/ncurses/current/ncurses-6.0-20170527.tgz
# tar zxvf ncurses-6.0-20170527.tgz
# cd ncurses-6.0-20170527
# sudo ./configure --prefix=/usr --with-shared --with-normal --with-debug --enable-overwrite
# sudo make 
# # test nurses in the test dir 
# sudo make install 

# wget http://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/n/ncurses-compat-libs-6.0-5.20160116.fc24.x86_64.rpm
wget ftp://rpmfind.net/linux/fedora/linux/releases/26/Everything/x86_64/os/Packages/n/ncurses-compat-libs-6.0-8.20170212.fc26.x86_64.rpm
sudo dnf install -y ncurses-compat-libs-6.0-8.20170212.fc26.x86_64.rpm

# install mysql
sudo rpm -ivh MySQL-*.rpm

#starting mysql 
sudo service mysql start 

