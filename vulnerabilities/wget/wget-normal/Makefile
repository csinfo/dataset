run_100:
	cnt=0; while [ $${cnt} -lt 100 ] ; do \
		rand=`expr $$RANDOM % 10` ; \
		sed -i "s/wget-[0-9].sh/wget-$${rand}.sh/" Vagrantfile ; \
		sed -i "s/wget-normal-[0-9]*.log/wget-normal-$${cnt}.log/" Vagrantfile ; \
		vagrant up --provider=virtualbox ; \
		vagrant halt -f ; \
		vagrant destroy -f ; \
		cnt=`expr $$cnt + 1` ; \
	done ; \

run: run_100
