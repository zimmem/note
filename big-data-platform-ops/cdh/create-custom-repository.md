# Create Custom Repository 



## create cloudera manager yum repository 

```
sudo yum install yum-utils createrepo

wget https://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo -O /etc/yum.repo.d/cloudera-manager.repo

reposync -r cloudera-manager


cd cloudera-manager
createrepo .

## upload to http server
```



# create custom parcels

```
# download all file on https://archive.cloudera.com/cdh5/parcels/5.13.1.2/
# upload to http server
```





\[1\]: [https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh\_ig\_yumrepo\_local\_create.html](https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh_ig_yumrepo_local_create.html)

\[2\]:https://archive.cloudera.com/cdh5/parcels/5.13.1.2/

