# Install Cloudera Manager on CentOS 6

```
# add repository or use your local repository
wget https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-manager.repo

# install JDK or you may install offical 1.8 jdk Manually from oracle
yum install oracle-j2sdk1.7

# install cloudera-manager-server and cloudera-manager-deamon
yum install cloudera-manager-daemons cloudera-manager-server

# download mysql-connector-java from http://www.mysql.com/downloads/connector/j/5.1.html
# make sure the mysql-connector-java place at /usr/share/java/mysql-connector-java.jar

# prepare database 

/usr/share/cmf/schema/scm_prepare_database.sh -h ${mysql-host}   mysql ${schema} ${user}

# start cloudera-scm-server 
service cloudera-scm-server start

```



\[1\]:https://www.cloudera.com/documentation/enterprise/release-notes/topics/rn\_consolidated\_pcm.html

\[2\]:https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm\_ig\_mysql.html

