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

#install cm 
apt-get install cloudera-manager-daemons cloudera-manager-server

```

[1]:[https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh_ig_cdh5_install.html#topic_4_4_1__section_dfx_p51_nj](https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh_ig_cdh5_install.html#topic_4_4_1__section_dfx_p51_nj)

[2]:[https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm_ig_install_path_b.html#cmig_topic_6_6](https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm_ig_install_path_b.html#cmig_topic_6_6)

