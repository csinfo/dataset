run_110:
	cnt=0; while [ $${cnt} -lt 110 ] ; do \
		sed -i "s/mysql-race-normal-[0-9]*.log/mysql-race-normal-$${cnt}.log/" Vagrantfile ; \
		vagrant up --provider=virtualbox ; \
		vagrant halt -f ; \
		vagrant destroy -f ; \
		cnt=`expr $$cnt + 1` ; \
	done ; \

run: run_110
