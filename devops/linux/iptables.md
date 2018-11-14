# iptables

## 端口转发

```bash
# 把发往 192.168.2.61 3001 端口的流量转发到 192.168.2.70:3306 如转发所有 ip -d 192.168.2.61 可不写
iptables -t nat -A PREROUTING -d 192.168.2.61 -p tcp --dport 3001 -j DNAT --to-destination 192.168.2.70:3306
# 把 192.168.2.70 回来的 tcp ip 改写成 192.168.2.70
iptables -t nat -A POSTROUTING -d 192.168.2.70 -p tcp --dport 3306 -j SNAT --to 192.168.2.61
```

## 删除规则

```
iptables -t nat -D PREROUTING 1
```

## 保存 iptables 

```
 iptables-save > /etc/iptables.rules
```



## 恢复 iptables

```
iptables-restore < /etc/iptables.rules
```



