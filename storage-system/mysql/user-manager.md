# User Management

## add root user

```sql
CREATE USER 'root'@'10.1.%' IDENTIFIED BY 'password';
grant all privileges on *.* to 'root'@'10.1.%' with grant option;
FLUSH PRIVILEGES;

-- 表级授权
grant select on dap.t_kmap_nutrition_billfare_info to 'food-ro'@'10.1.%';
```



