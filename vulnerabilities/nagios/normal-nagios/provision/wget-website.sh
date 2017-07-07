#!/bin/bash
cd /home/vagrant/Downloads
for i in {1..10}
do
	wget http://192.168.33.10
done

#done by the client, just to make sure that the apache web server is running 