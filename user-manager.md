# User Management

## add root user

```sql
CREATE USER 'root'@'10.1.%' IDENTIFIED BY 'password';
grant all privileges on *.* to 'root'@'10.1.%' with grant option;
FLUSH PRIVILEGES;
```



