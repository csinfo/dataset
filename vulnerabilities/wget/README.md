instruction on reproducing wget vulnerability provenance data using this Vagrantfile 

1. To simulate the normal behavior of wget: comment out the following line(s)
    client.vm.provision "shell", path: "provision/client-pre-provision-bad.sh"

2. To simulate the exploited behavior of wget: comment out the following line(s)
    client.vm.provision "shell", path: "provision/client-pre-provision-good.sh"
    client.vm.provision "shell", path: "provision/wget-normal.sh"

3. To simulate the exploited and the normal behavior of wget: comment out the following line(s)
    client.vm.provision "shell", path: "provision/client-pre-provision-good.sh"
