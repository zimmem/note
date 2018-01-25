# **Create Cloudera Manager extensions **

<!-- toc -->

>**success**
> 以支持腾讯云 COS 为例

## 构建 parcel 包

> 通过 parcel 机制给 cdh 中的 yarn 添加 cos 支持， 使 yarn 应用能直接访问 cos 上的文件

腾讯云 cos 支持通过 hdfs 访问([Hadoop 工具][1])， 但公司大数据集群使用 CDH 管理， 直接修改配置虽然可行， 但每台机器都登录上去部署非常繁琐， 且万一下次通过 Clouder Manager 更新配置， 又会把配置覆盖掉， 所以要找出一种方式看能否通过 clouder manager 来做这种增强， 查了CDH 官方资料后发现应该可以通过 pracel 以插件的方式来把 cos-hadoop 部署到集群中。

parcel 文件格式参考[The parcel format][2]， 主要有以下几个文件组成

* meta/parcel.json
* meta/filelist.json
* meta/cos_env.json
* meta/alternatives.json 
* 其它 lib 文件

### parcel `描述文件 meta/parcel.json`
格式参考 [The parcel.json file][5]

```json
{
  "schema_version":     1,
  "name":               "HADOOP_COS",
  "version":            "2.7.2.2",
  "extraVersionInfo": {
    "fullVersion":        "2.7.2.2",
    "baseVersion":        "2.7.2.2",
    "patchCount":         ""
  },

  "conflicts":          "CDH (<< 5.13.1), CDH (>> 5.13.1.)",

  "setActiveSymlink":   true,

  "scripts": {
    "defines": "cos_env.sh"
  },

  "packages": [
    { "name":    "cos-hadoop",
      "version": "2.7.2.2"
    }
  ],

  "components": [
    { "name":    "cos-hadoop",
      "version": "2.7.2.2",
      "pkg_version": "2.7.2.2"
    }
  ],

  "provides": [
    "yarn-plugin",
    "mapreduce-plugin",
    "mapreduce2-plugin"
  ],

  "users": { },

  "groups": [ ]
}


```

### 文件列表 `meta/filelist.json`

描述插件中每个组件的文件列表 
```json
{
   "cos-hadoop" : {
    "name": "cos-hadoop",
    "version": "2.7.2",
    "files" : {
      "jars" : {},
      "jars/cos_api-4.2.jar" : {},
      "jars/hadoop-cos-2.7.2.jar" : {},
      "jars/httpmime-4.2.5.jar" : {},
      "json-20140107.jar" : {}
    }
  }
}

```
### Defind Script `meta/cos_env.json`

Defind Script 用于在插件影响到的组件启动时执行， 一般是把插件的 jar 包加入到组件的 classpath 中。 组件启动时以 `source defind.script ` 方式调用。 插件影响到哪些组件在 `meta/parcel.json` 中的 `provides` 定义， 组件名称参考 [Service parcel tags recognised by cloudera manager][7], 脚本中用到的 classpath 变量名参考 [Plugin parcel environment variables][8]

```bash
#!/bin/bash
HADOOP_COS_DIRNAME=${PARCEL_DIRNAME:-"HADOOP_COS"}

# if [ -n "${HADOOP_CLASSPATH}" ]; then
#   export HADOOP_CLASSPATH="${HADOOP_CLASSPATH}:$PARCELS_ROOT/$HADOOP_COS_DIRNAME/jars/*"
# else
#   export HADOOP_CLASSPATH="$PARCELS_ROOT/$HADOOP_COS_DIRNAME/jars/*"
# fi

if [ -n "${MR2_CLASSPATH}" ]; then
  export MR2_CLASSPATH="${MR2_CLASSPATH}:$PARCELS_ROOT/$HADOOP_COS_DIRNAME/jars/*"
else
  export MR2_CLASSPATH="$PARCELS_ROOT/$HADOOP_COS_DIRNAME/jars/*"
fi
```

### 软链接描述 `meta/alternatives.json`

用于建立软链接， hadoop_cos 中没有用到， 参考[The alternatives.json file][4]

### 构建 parcel 文件

参考 [Building a parcel][9], parcel 文件实际是一个 `.tar.gz ` 文件

```
tar zcvf GPLEXTRAS-5.0.0-gplextras5b2.p0.32-el6.parcel GPLEXTRAS-5.0.0-gplextras5b2.p0.32/ --owner=root --group=root
```

> parcel 文件名必须符合格式 `${parcel_name}-${version}-${distro_suffixes}.pracel`, 其中 `${distro_suffixes}` 参考 [Parcel distro suffixes][10]

使用 [validator][11] 检验文件合法性
使用 [make_manifest.py][12] 创建 parcel 描述 文件

## 安装 parcel （略）
## 修改 hdfs配置

路径
Cloudera Manager -> HDFS -> Configuration -> Scope(Gateway) 
配置项 HDFS Client Advanced Configuration Snippet (Safety Valve) for hdfs-site.xml
内容
```xml
    <property>
        <name>fs.cos.userinfo.appid</name>
        <value>your cos app id </value>
    </property>
    <property>
        <name>fs.cos.userinfo.secretId</name>
        <value>your cos secret id </value>
    </property>
    <property>
        <name>fs.cos.userinfo.secretKey</name>
        <value>your cos secret key</value>
    </property>
    <property>
        <name>fs.cosn.impl</name>
        <value>org.apache.hadoop.fs.cosnative.NativeCosFileSystem</value>
    </property>
    <property>
        <name>fs.cos.buffer.dir</name>
        <value>/data/cos/buffer</value>
    </property>
    <property>
        <name>fs.cos.userinfo.region</name>
        <value>gz</value>
    </property>
```

[1]:https://cloud.tencent.com/document/product/436/6884
[2]:https://github.com/cloudera/cm_ext/wiki/The-parcel-format
[3]:https://github.com/cloudera/cm_ext/wiki/The-parcel-defines-script
[4]:https://github.com/cloudera/cm_ext/wiki/The-alternatives.json-file
[5]:https://github.com/cloudera/cm_ext/wiki/The-parcel.json-file
[6]:https://github.com/cloudera/cm_ext/wiki/The-parcel-defines-script
[7]:https://github.com/cloudera/cm_ext/wiki/Service-parcel-tags-recognised-by-cloudera-manager
[8]:https://github.com/cloudera/cm_ext/wiki/Plugin-parcel-environment-variables
[9]:https://github.com/cloudera/cm_ext/wiki/Building-a-parcel
[10]:https://github.com/cloudera/cm_ext/wiki/Parcel-distro-suffixes
[11]:https://github.com/cloudera/cm_ext/tree/master/validator
[12]:https://github.com/cloudera/cm_ext/tree/master/make_manifest