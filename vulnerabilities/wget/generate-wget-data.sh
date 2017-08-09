cd wget-exploit/
vagrant up
vagrant destroy -f

cd ../wget-normal/
vagrant up
vagrant destroy -f

cd ../wget-mixed/
vagrant up
vagrant destroy -f

cd ../wget-validate/
vagrant up 
vagrant destroy -f