# Install Cloudera Manager on Ubuntu 16

## Install JDK 

```bash
cd /etc/apt/source.list.d/
# add cloudera source 
wget https://archive.cloudera.com/cm5/ubuntu/xenial/amd64/cm/cloudera.list
# add gpg key
curl https://archive.cloudera.com/cm5/ubuntu/xenial/amd64/cm/archive.key | apt-key add -

apt update 

# install jdk 1.7
apt-get install oracle-j2sdk1.7
```





\[1\]:[https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh\_ig\_cdh5\_install.html\#topic\_4\_4\_1\_\_section\_dfx\_p51\_nj](https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh_ig_cdh5_install.html#topic_4_4_1__section_dfx_p51_nj)

\[2\]:https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm\_ig\_install\_path\_b.html\#cmig\_topic\_6\_6

