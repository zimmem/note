# **Create Cloudera Manager extensions**


## QCloud COS support to yarn on CDH

> 通过 parcel 机制给 cdh 中的 yarn 添加 cos 支持， 使 yarn 应用能直接访问 cos 上的文件

腾讯云 cos 支持通过 hdfs 访问([Hadoop 工具][1])， 但公司大数据集群使用 CDH 管理， 直接修改配置虽然可行， 但每台机器都登录上去部署非常繁琐， 且万一下次通过 Clouder Manager 更新配置， 又会把配置覆盖掉， 所以要找出一种方式看能否通过 clouder manager 来做这种增强， 查了CDH 官方资料后发现应该可以通过 pracel 以插件的方式来把 cos-hadoop 部署到集群中。

parcel 文件格式参考[The parcel format][2]， 主要有以下几个文件组成

* meta/filelist.json
* meta/parcel.json
* meta/cos_env.json  参考[The parcel defines script][3]
* meta/alternatives.json


```

```

## 参考资料

[The alternatives.json file](https://github.com/cloudera/cm_ext/wiki/The-alternatives.json-file)  

[Service parcel tags recognised by cloudera manager](https://github.com/cloudera/cm_ext/wiki/Service-parcel-tags-recognised-by-cloudera-manager)  
[Parcel distro suffixes](https://github.com/cloudera/cm_ext/wiki/Parcel-distro-suffixes)  
[Plugin parcel environment variables](https://github.com/cloudera/cm_ext/wiki/Plugin-parcel-environment-variables)

[1]:https://cloud.tencent.com/document/product/436/6884
[2]:https://github.com/cloudera/cm_ext/wiki/The-parcel-format
[3]:https://github.com/cloudera/cm_ext/wiki/The-parcel-defines-script
