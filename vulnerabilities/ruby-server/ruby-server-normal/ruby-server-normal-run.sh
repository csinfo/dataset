vagrant up 
vagrant ssh server <<'EOF'
sleep 5
sudo camflow -e false
sleep 30
cp /tmp/audit.log /vagrant/prov-data/ruby-server-normal-data.log
EOF