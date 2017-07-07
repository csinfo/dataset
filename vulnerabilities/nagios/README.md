									The meat of the exploit

"Nagios daemon was found to open the log file before dropping its root privileges on startup.

If an attacker managed to gain access to an account of 'nagios' or any
other account belonging to the 'nagios' group, they would be able to
replace the log file with a symlink to an arbitrary file on the system.

This vulnerability could be used by an attacker to escalate their privileges
from nagios user/group to root for example by creating a malicious 
/etc/ld.so.preload file." (credit to: https://legalhackers.com)

An important point to note is that a user has to have root privilages in order to have read/write permissions in directory /etc 


									Simulation and Obtain data
To simulate exploited behavior and consequently get its provenance data, go to 'exploite-nagios' folder and do 'vagrant up'. 

To simulate normal behavior and get its provenance data, go to 'normal-nagios' folder and do 'vagrant up'. 

(Note: the provenance data you will get is pinging 5 times of the server with check_ping commands, with the same parameters as check-host-alive. This simulated interaction with nagios is done by check_ping.sh provision. Write your own provision to get more provenance data of the usual behavior of nagios based on how you would personally interact/use it! Check out commands.cfg) 


									Files 
commands.cfg - a file that user can take a look to see how they can interact with nagios which supposedly monitors the servers, networks, infrastructure of their chioce

 

