# generating data
cd vulnerabilities
./mariadb-race/generate-mariadb-race-data.sh
./mariadb-root/generate-mariadb-root-data.sh
./mysql-race/generate-mysql-race-data.sh
./mysql-root/generate-mysql-root-data.sh
./percona-race/generate-percona-race-data.sh
./percona-root/generate-percona-root-data.sh
./tomcat-local/generate-tomcat-local-data.sh
./tomcat-remote/generate-tomcat-remote-data.sh 
./nagios/generate-nagios-data.sh
./ruby-server/generate-ruby-server-data.sh
./wget/generate-wget-data.sh
cd ..

# moving data
mv /vulnerabilities/mariadb-race/mariadb-race-exploit/prov-data/mariadb-race-exploit-data.log vul-experimental-data/mariadb-race/bad-behv/
mv /vulnerabilities/mariadb-race/mariadb-race-normal/prov-data/mariadb-race-normal-data.log vul-experimental-data/mariadb-race/good-behv/

mv /vulnerabilities/mariadb-root/mariadb-root-exploit/prov-data/mariadb-root-exploit-data.log vul-experimental-data/mariadb-root/bad-behv/
mv /vulnerabilities/mariadb-root/mariadb-root-normal/prov-data/mariadb-root-normal-data.log vul-experimental-data/mariadb-root/good-behv/

mv /vulnerabilities/mysql-race/mysql-race-exploit/prov-data/mysql-race-exploit-data.log vul-experimental-data/mysql-race/bad-behv/
mv /vulnerabilities/mysql-race/mysql-race-normal/prov-data/mysql-race-normal-data.log vul-experimental-data/mysql-race/good-behv/

mv /vulnerabilities/mysql-root/mysql-root-exploit/prov-data/mysql-root-exploit-data.log vul-experimental-data/mysql-root/bad-behv/
mv /vulnerabilities/mysql-root/mysql-root-normal/prov-data/mysql-root-normal-data.log vul-experimental-data/mysql-root/good-behv/

mv /vulnerabilities/percona-race/percona-race-exploit/prov-data/percona-race-exploit-data.log vul-experimental-data/percona-race/bad-behv/
mv /vulnerabilities/percona-race/percona-race-normal/prov-data/percona-race-normal-data.log vul-experimental-data/percona-race/good-behv/

mv /vulnerabilities/percona-root/percona-root-exploit/prov-data/percona-root-exploit-data.log vul-experimental-data/percona-root/bad-behv/
mv /vulnerabilities/percona-root/percona-root-normal/prov-data/percona-root-normal-data.log vul-experimental-data/percona-root/good-behv/

mv /vulnerabilities/tomcat-local/tomcat-exploit/prov-data/tomcat-local-exploit-data.log vul-experimental-data/tomcat-local/bad-behv/
mv /vulnerabilities/tomcat-local/tomcat-normal/prov-data/tomcat-local-normal-data.log vul-experimental-data/tomcat-local/good-behv/

mv /vulnerabilities/tomcat-remote/tomcat-exploit/prov-data/tomcat-remote-exploit-data.log vul-experimental-data/tomcat-remote/bad-behv/
mv /vulnerabilities/tomcat-remote/tomcat-normal/prov-data/tomcat-normal-exploit-data.log vul-experimental-data/tomcat-remote/good-behv/

mv /vulnerabilities/nagios/nagios-exploit/prov-data/nagios-exploit-data.log vul-experimental-data/nagios/bad-behv/
mv /vulnerabilities/nagios/nagios-normal/prov-data/nagios-normal-data.log vul-experimental-data/nagios/good-behv/

mv /vulnerabilities/ruby-server/ruby-server-exploit/prov-data/ruby-server-exploit-data.log vul-experimental-data/ruby-server/bad-behv/
mv /vulnerabilities/ruby-server/ruby-server-normal/prov-data/ruby-server-normal-data.log vul-experimental-data/ruby-server/good-behv/

mv /vulnerabilities/wget/wget-exploit/prov-data/wget-exploit-data.log vul-experimental-data/wget/bad-behv/
mv /vulnerabilities/wget/wget-normal/prov-data/wget-normal-data.log vul-experimental-data/wget/good-behv/ 
mv /vulnerabilities/wget/wget-mixed/prov-data/wget-mixed-data.log vulnerabilities/wget/mixed-behv/
mv /vulnerabilities/wget/wget-validate/prov-data/wget-validate-data.log vulnerabilities/wget/validate/