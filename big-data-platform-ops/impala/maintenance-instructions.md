# Impala Maintenance Instructions

* **refresh [schema].table**

    当 hdfs 文件发生变更后使用该使令刷新  
    
* **INVALIDATE METADATA [[db_name.]table_name]**
    
    当 hive 表元数据发生变更，且不是由 Impala 引起的， 调用该指令刷新 metadata 缓存