sudo dnf install -y nrpe nagios-plugins-all 
sudo systemctl start nrpe.service 
sudo systemctl enable nrpe.service 

#from here on, it will simulate how a ussr normally use nagios 
sudo touch /usr/local/nagios/etc/servers/local.cfg
sudo cat<<EOF>>/usr/local/nagios/etc/servers/local.cfg
define host {
        use                             linux-server
        host_name                       local
        alias                           local apache server 
        address                         127.0.0.1
        max_check_attempts              5
        check_period                    24x7
        notification_interval           30
        notification_period             24x7
}

define service {
        use                             generic-service
        host_name                       local
        service_description             PING
        check_command                   check_ping!100.0,20%!500.0,60%
}

define service {
        use                             generic-service
        host_name                       local
        service_description             SSH
        check_command                   check_ssh
        notifications_enabled           0
}
EOF

#configure camflow to track appropriate file(s) This step has to be done before reload/restart/start of nagios
sudo camflow --track-file /etc/rc.d/init.d/nagios propagate

sudo systemctl reload nagios.service


