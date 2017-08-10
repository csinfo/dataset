# solve SSH issues that would have occurred after packaging the box
sudo rm /home/vagrant/.ssh/*

sudo wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys 
sudo chmod 0700 /home/vagrant/.ssh  
sudo chmod 0600 /home/vagrant/.ssh/authorized_keys 
sudo chown -R vagrant /home/vagrant/.ssh

#clean up before repackage 
#reboot the machine to the camflow kernel to remove these files
sudo rm /etc/camflow-boot_id
sudo rm /etc/camflow-machine_id
sudo /vagrant/repackage/clean-up-script.sh