# SSH Client Config


> [ssh_config(5) - Linux man page](https://linux.die.net/man/5/ssh_config)

配置文件的 
* /etc/ssh/ssh_config
* $HOME/.ssh/config

配置客户端每60秒发一个包保持活跃， 防止被 Server 断开

```
Host *
    ServerAliveInterval 60
```
