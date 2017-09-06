run_110:
	cnt=0; while [ $${cnt} -lt 110 ] ; do \
		sed -i "s/nagios-normal-[0-9]*.log/nagios-normal-$${cnt}.log/" Vagrantfile ; \
		vagrant up --provider=virtualbox ; \
		vagrant halt -f ; \
		vagrant destroy -f ; \
		cnt=`expr $$cnt + 1` ; \
	done ; \

run: run_110
