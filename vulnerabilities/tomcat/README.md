Instructions on reproducing tomcat vulnerability provenance data

1. To simulate the normal behavior of tomecat: comment out the following line(s)
  cLient.vm.provision "shell", path: "provision/bad_tomcat.sh"

2. To simulate the eploited behavior of tomcat: comment out the following line(s)
 client.vm.provision "shell", path: "provision/normal_tomcat.sh"

3. To simulate both the exploited and the normal behavior of tomcat: leave Vagrantfile as it is 
