# 问题诊断

## 性能

## 存储

* 查看磁盘空间
```bash
df -h 
```
* 查看inode 情况
```bash
# 查看挂载目录的 inode
df -i
# 查看哪个目录存在大量文件
find  -size +4k -type d |xargs ls -ldhi
```

## 网络

## 内存