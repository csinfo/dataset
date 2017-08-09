sudo touch /etc/systemd/system/nagios.service
sudo cat <<EOF>>/etc/systemd/system/nagios.service
[Unit]
Description=Nagios
BindTo=network.target


[Install]
WantedBy=multi-user.target

[Service]
User=nagios
Group=nagios
Type=simple
#ExecStart=/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg
ExecStart=/etc/rc.d/init.d/nagios start
ExecStop=/etc/rc.d/init.d/nagios stop
ExecReload=/etc/rc.d/init.d/nagios reload 
Restart=always
RestartSec=30
EOF
