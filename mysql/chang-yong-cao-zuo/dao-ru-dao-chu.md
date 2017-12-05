# 数据导入导出



```
## 导出
mysqldump -h ${host} -u ${user} -p ${db} ${table} [--where='1=1']  > file.sql

## 导入
 mysql -u root -p ${db} < file.sql
```



