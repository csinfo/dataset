The meat of this exploit is that 

"Nagios daemon was found to open the log file before dropping its root privileges on startup.

If an attacker managed to gain access to an account of 'nagios' or any
other account belonging to the 'nagios' group, they would be able to
replace the log file with a symlink to an arbitrary file on the system.

This vulnerability could be used by an attacker to escalate their privileges
from nagios user/group to root for example by creating a malicious 
/etc/ld.so.preload file." (credit to: https://legalhackers.com)

An important point to note is that a user has to have root privilages in order to have read/write permissions in directory /etc 

