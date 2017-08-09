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
sudo grub2-set-default "Fedora (4.12.4camflow-0.3.4) 26 (Workstation Edition)"



# solve SSH issues that would have occurred after packaging the box
sudo rm /home/vagrant/.ssh/*

sudo wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys 
sudo chmod 0700 /home/vagrant/.ssh  
sudo chmod 0600 /home/vagrant/.ssh/authorized_keys 
sudo chown -R vagrant /home/vagrant/.ssh

#/vagrant/provision/expect.sh

# curl -s https://packagecloud.io/install/repositories/camflow/provenance/script.rpm.sh.rpm | sudo bash
# sudo dnf install kernel-headers-4.12.4camflow_0.3.4-1.x86_64

# specifying kernel src
export KERN_DIR=/usr/src/kernels/4.12.4camflow-0.3.4

#clean up before repackage 
sudo rm /etc/camflow-boot_id
sudo rm /etc/camflow-machine_id
sudo /vagrant/repackage/clean-up.sh