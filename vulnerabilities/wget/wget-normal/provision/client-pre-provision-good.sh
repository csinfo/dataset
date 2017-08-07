# disabling firewall. Creating the same environment as the one for exploit 
sudo systemctl disable firewalld
sudo systemctl stop firewalld 

# download and config wget 
cd /usr/share/
sudo wget "ftp://195.220.108.108/linux/fedora/linux/releases/24/Everything/x86_64/os/Packages/w/wget-1.17.1-4.fc24.x86_64.rpm"
sudo dnf install -y wget-1.17.1-4.fc24.x86_64.rpm

