sudo sed -i 's/Restart=on-abort/Restart=always/' /etc/systemd/system/multi-user.target.wants/mariadb.service

sudo systemctl daemon-reload
sudo systemctl start mysql