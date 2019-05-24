# network

支持非root 用户使用 80 端口

```
setcap cap_net_bind_service=+ep /usr/local/bin/node
```