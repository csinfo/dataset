sudo touch /var/www/html/index.html 
sudo cat<<EOF>>/var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
	<title>Hello World</title>
</head>
<body>
Hello nagios. This page is used for simulating the normal behavior of nagios
</body>
</html>
EOF

#flushing the iptable before the client can send http requests
sudo iptables -F
