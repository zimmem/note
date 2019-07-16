---
tags:
    - 分布式一致性
    - 一致性
    - 分布式事务
keyWords:
    - ZAB
---

# ZAB 协议

## 前提

1. zookeeper 一般部署奇数个实例， 每个实例启动时必须指定一个配置文件声明每个实例的 id 及 主机， 配置如下：
    ```properties
    server.1=zoo1:2888:3888
    server.2=zoo2:2888:3888
    server.3=zoo3:2888:3888
    ```
    > https://zookeeper.apache.org/doc/r3.3.2/zookeeperAdmin.html#sc_zkMulitServerSetup
2. zk集群有三种角色
   * Leader
   * Follower
   * Observer (不参与投票， 可忽略)
3. 集群结点有三种状态
   * Looking  - 选举中
   * Leading - Leader  的状态
   * Following - Follower 的状态

## Leader 选举

### Fast paxos

默认ZAB采用的算法是fast paxos算法。

### basic paxos

## 消息广播

## 崩溃恢复


!!! WARNING 
    To Be Continue...  




[^1]: [十分钟了解ZAB协议](https://zhuanlan.zhihu.com/p/44207241)
[^2]: [ZAB协议选主过程详解](https://zhuanlan.zhihu.com/p/27335748)
[^3]: https://blog.csdn.net/world6/article/details/79873132
