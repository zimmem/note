# Install Mysql Server by Yum

## Edit /etc/yum.repos.d/mysql-community.repo

```
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```

## Install and Start

```
 yum install mysql-community-server
 service mysqld start 
```

启动后到 /var/log/mysqld.log 找初始密码



## Securing the MySQL Installation

```
mysql_secure_installation
```



