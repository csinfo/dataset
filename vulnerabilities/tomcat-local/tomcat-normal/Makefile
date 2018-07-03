run_10:
	cnt=50; while [ $${cnt} -lt 110 ] ; do \
		sed -i "s/tomcat-local-normal-[0-9]*.log/tomcat-local-normal-$${cnt}.log/" Vagrantfile ; \
		vagrant up --provider=virtualbox ; \
		vagrant halt -f ; \
		vagrant destroy -f ; \
		cnt=`expr $$cnt + 1` ; \
	done ; \

run: run_10
