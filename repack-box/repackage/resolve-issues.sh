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

#/vagrant/provision/expect.sh

# curl -s https://packagecloud.io/install/repositories/camflow/provenance/script.rpm.sh.rpm | sudo bash
# sudo dnf install kernel-headers-4.12.4camflow_0.3.4-1.x86_64

# specifying kernel src
# export KERN_DIR=/usr/src/kernels/4.12.4camflow-0.3.4


# # manually update guest additions to match the host 
# cd /home/vagrant
# wget http://download.virtualbox.org/virtualbox/5.1.26/VBoxGuestAdditions_5.1.26.iso
# sudo mkdir /media/VBoxGuestAdditions
# sudo mount -o loop,ro VBoxGuestAdditions_5.1.26.iso /media/VBoxGuestAdditions
# sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
# rm VBoxGuestAdditions_5.1.26.iso
# sudo umount /media/VBoxGuestAdditions
# sudo rmdir /media/VBoxGuestAdditions
# # fix bug in guest additions isntaller 
# # https://stackoverflow.com/questions/28494349/vagrant-failed-to-mount-folders-in-linux-guest-vboxsf-file-system-is-not-av
# sudo ln -s /opt/VBoxGuestAdditions-5.1.26/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions

