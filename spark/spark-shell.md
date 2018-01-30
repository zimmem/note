# Spark Shell

## 提高 spark-shell 性能

```shell
spark-shell \
--conf spark.driver.cores=2 \
--driver-memory 3G \
--num-executors 6 \
--conf spark.executor.cores=3 \
--executor-memory 4G
```