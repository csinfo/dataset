# apple
vagrant up
vagrant halt
vagrant destroy -f 

# cnn
sed -i.bak 's#wget-apple.sh#wget-cnn.sh#' Vagrantfile
sed -i.bak 's#wget-normal-apple.log#wget-normal-cnn.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# fb
sed -i.bak 's#wget-cnn.sh#wget-fb.sh#' Vagrantfile
sed -i.bak 's#wget-normal-cnn.log#wget-normal-fb.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# yahoo
sed -i.bak 's#wget-fb.sh#wget-yahoo.sh#' Vagrantfile
sed -i.bak 's#wget-normal-fb.log#wget-normal-yahoo.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# twitter
sed -i.bak 's#wget-yahoo.sh#wget-twitter.sh#' Vagrantfile
sed -i.bak 's#wget-normal-yahoo.log#wget-normal-twitter.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# httpd
sed -i.bak 's#wget-twitter.sh#wget-httpd.sh#' Vagrantfile
sed -i.bak 's#wget-normal-twitter.log#wget-normal-httpd.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# lynx
sed -i.bak 's#wget-httpd.sh#wget-lynx.sh#' Vagrantfile
sed -i.bak 's#wget-normal-httpd.log#wget-normal-lynx.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# php
sed -i.bak 's#wget-lynx.sh#wget-php.sh#' Vagrantfile
sed -i.bak 's#wget-normal-lynx.log#wget-normal-php.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# vim
sed -i.bak 's#wget-php.sh#wget-vim.sh#' Vagrantfile
sed -i.bak 's#wget-normal-php.log#wget-normal-vim.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f


# google
sed -i.bak 's#wget-vim.sh#wget-google.sh#' Vagrantfile
sed -i.bak 's#wget-normal-vim.log#wget-normal-google.log#' Vagrantfile
vagrant up 
vagrant halt
vagrant destroy -f

# change back to apple
sed -i.bak 's#wget-google.sh#wget-apple.sh#' Vagrantfile
sed -i.bak 's#wget-normal-google.log#wget-normal-apple.log#' Vagrantfile
