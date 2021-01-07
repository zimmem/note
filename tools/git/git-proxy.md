# 配置 git 代理

## 配置指定域名 ssh 协议走 http 代理 

```
Host github.com
    User git
    HostName ssh.github.com
    Port 443
    proxycommand socat - PROXY:<proxy host>:%h:%p,proxyport=<port:8080>
```
