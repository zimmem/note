# Performance diagnosis

## 查看进程内存占用 

### 方法一 pmag

```
pmag -x 1

1:   java -jar /xxx/x.jar
Address           Kbytes     RSS   Dirty Mode   Mapping
0000000000400000    6736    2692       0 r-x--  php-cgi
0000000000c93000     264     196     120 rw---  php-cgi
0000000000cd5000      60      48      48 rw---    [ anon ]
. . .
00007fd6226bc000       4       4       4 rw---  ld-2.12.so
00007fd6226bd000       4       4       4 rw---    [ anon ]
00007fff84b02000      96      96      96 rw---    [ stack ]
00007fff84bff000       4       4       0 r-x--    [ anon ]
ffffffffff600000       4       0       0 r-x--    [ anon ]
----------------  ------  ------  ------
total kB          438284  113612  107960

```

关键信息点

* 进程ID

* 启动命令「java -jar /xxx/x.jar」

* RSS :占用的物理内存 113612KB

### 方案二

cat /proc/1/status



