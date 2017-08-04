"Nagios daemon was found to open its error log file before dropping its root privileges on startup.

If an attacker can somehow gain access to an account of 'nagios' or any
other account belonging to the 'nagios' group, which can be done through another vulnerability,
they would be able to replace the log file with a symlink to an arbitrary file on the system.

This vulnerability could be used by an attacker to escalate their privileges
from nagios user/group to root for example by creating a malicious 
/etc/ld.so.preload file." (credit to: https://legalhackers.com)

An important point to note is that a user has to have root privilages in order to have read/write permissions in directory /etc 


						Simulation and Obtain data
To simulate exploited behavior and consequently get its provenance data, go to 'exploite-nagios' folder and do 'vagrant up'. 

To simulate normal behavior and get its provenance data, go to 'normal-nagios' folder and do 'vagrant up'. 

In the normal behavior simulation, it's simulating a correct startup of the nagios service in contrast to a
symlink attacker. However, you can also generate the actual normal general use of nagios. For example, take
a look at the Vagrantfile, and uncommnet the client VM section to boot up another VM. 

The insert-index-html-on-server.sh and add-monitored-server-to-nagios.sh provisioning files can be commnented out for adding a website on the server. The wget-website.sh provisioning file on the client VM is just there
to verify that the server is correctly serving the website. There is another check_ping.sh file on the server 
that uses nagios to ping the local website. The provenance data you will get is pinging 5 times of the server with check_ping commands, with the same parameters as check-host-alive. This simulated interaction with nagios is done by check_ping.sh provision. Write your own provision to get more provenance data of the usual behavior of nagios based on how you would personally interact/use it! Check out commands.cfg. 


						Files 
commands.cfg - a file that user can take a look to see how they can interact with nagios which supposedly monitors the servers, networks, infrastructure of their chioce


						Known Issues: 
"server" VM doesn't restart with default kernal after first 'vagrant up'

 

