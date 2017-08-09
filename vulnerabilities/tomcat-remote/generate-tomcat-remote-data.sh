cd tomcat-exploit/
./tomcat-exploit-run.sh
vagrant destroy -f 

cd ../tomcat-normal/
vagrant up 
vagrant destroy -f