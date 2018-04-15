# Read/Write hive table when running spark2 by oozie

## 问题描述

CDH 5.12 集群安装 [spark2](https://www.cloudera.com/documentation/spark2/latest/topics/spark2_installing.html) 后, 在机器上直接通过  spark2-shell 或 spark2-submit 都能支持 `spark.sql` 读写 hive 表， 但当通过 oozie 的 shell action 时， spark 读取不到 hive catalog ， 因而无法读写 hive 表， 不管是直接在 shell 结点直接调 spark2-submit 或者把命令放在 sh 脚本里， 也不管 `--deploy-mode` 是 `client` 或 `cluster`

## 问题查找

1. 通过对比两种不同方式调起的 java 进程的 classpath , 发现通过 oozie 调起的进程 classpath 中少了 `/opt/cloudera/parcels/SPARK2-2.2.0.cloudera2-1.cdh5.12.0.p0.232957/lib/spark2/conf/yarn-conf` 这个目录
2. 使用 debug 模式(`bash -x `) 诊断上述目录是如何加入到 classpath 中的， 最终发现在 ` /opt/cloudera/parcels/SPARK2-2.2.0.cloudera2-1.cdh5.12.0.p0.232957/lib/spark2/conf/spark-env.sh` 中有
```bash
HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$SPARK_CONF_DIR/yarn-conf}
```
3. 用同样方法查找 oozie 中执行 spark2-submit 没有把上述目录加入 classpath 的原因， 发现oozie 执行脚本是，
`HADOOP_CONF_DIR` 已被设置为 `/data/yarn/nm/usercache/icarbonx/appcache/application_1521461396754_4654/container_e37_1521461396754_4654_01_000002/oozie-hadoop-conf-1523771262850`， 继续阅读 oozie 相关源码，找到最终原因， 相关代码如下

{% github_embed "https://github.com/apache/oozie/blob/release-4.3.1/sharelib/oozie/src/main/java/org/apache/oozie/action/hadoop/ShellMain.java#L140-L156" %}{% endgithub_embed %}


{% github_embed "https://github.com/apache/oozie/blob/release-4.3.1/sharelib/oozie/src/main/java/org/apache/oozie/action/hadoop/LauncherMain.java#L48-L283", hideLines=['50-58', '62-272', '7-10'] %}{% endgithub_embed %}
