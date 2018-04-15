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

```java
//https://github.com/apache/oozie/blob/release-4.3.1/sharelib/oozie/src/main/java/org/apache/oozie/action/hadoop/ShellMain.java
public class ShellMain extends LauncherMain {

 private void prepareHadoopConfigs(Configuration actionConf, Map<String, String> envp, File currDir) throws IOException {
        if (actionConf.getBoolean(CONF_OOZIE_SHELL_SETUP_HADOOP_CONF_DIR, false)) {
            String actionXml = envp.get(OOZIE_ACTION_CONF_XML);
            if (actionXml != null) {
                File confDir = new File(currDir, "oozie-hadoop-conf-" + System.currentTimeMillis());
                writeHadoopConfig(actionXml, confDir);
                if (actionConf.getBoolean(CONF_OOZIE_SHELL_SETUP_HADOOP_CONF_DIR_WRITE_LOG4J_PROPERTIES, true)) {
                    System.out.println("Writing " + LOG4J_PROPERTIES + " to " + confDir);
                    writeLoggerProperties(actionConf, confDir);
                }
                System.out.println("Setting " + HADOOP_CONF_DIR + " and " + YARN_CONF_DIR
                    + " to " + confDir.getAbsolutePath());
                envp.put(HADOOP_CONF_DIR, confDir.getAbsolutePath());
                envp.put(YARN_CONF_DIR, confDir.getAbsolutePath());
            }
        }
    }


}
```

```java
//https://github.com/apache/oozie/blob/release-4.3.1/sharelib/oozie/src/main/java/org/apache/oozie/action/hadoop/LauncherMain.java

public abstract class LauncherMain {

     protected static String[] HADOOP_SITE_FILES = new String[]
            {"core-site.xml", "hdfs-site.xml", "mapred-site.xml", "yarn-site.xml"};
            
     protected void writeHadoopConfig(String actionXml, File basrDir) throws IOException {
        File actionXmlFile = new File(actionXml);
        System.out.println("Copying " + actionXml + " to " + basrDir + "/" + Arrays.toString(HADOOP_SITE_FILES));
        basrDir.mkdirs();
        File[] dstFiles = new File[HADOOP_SITE_FILES.length];
        for (int i = 0; i < dstFiles.length; i++) {
            dstFiles[i] = new File(basrDir, HADOOP_SITE_FILES[i]);
        }
        copyFileMultiplex(actionXmlFile, dstFiles);
    }
}

```