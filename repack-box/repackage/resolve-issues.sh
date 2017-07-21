# prerequisite 
#sudo dnf install -y expect

# diable GUI 
sudo systemctl set-default multi-user.target



# set up default kernel on boot 
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i '/GRUB_SAVEDEFAULT=true/d' /etc/default/grub
sudo sed -i '$ a GRUB_SAVEDEFAULT=false' /etc/default/grub

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

#kernel=$(grep -P "submenu|^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2 | grep camflow)
sudo grub2-set-default "Fedora (4.11.6camflow-0.3.3) 25 (Workstation Edition)"



# solve SSH issues that would have occurred after packaging the box
echo 0
sudo rm /home/vagrant/.ssh/*
echo 1

sudo wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys 
echo 2 
sudo chmod 0700 /home/vagrant/.ssh  
echo 3
sudo chmod 0600 /home/vagrant/.ssh/authorized_keys 
echo 4
sudo chown -R vagrant /home/vagrant/.ssh
echo 5

#/vagrant/provision/expect.sh

#clean up before repackage 
sudo /vagrant/repackage/clean-up.sh