# Spark Submit

--conf "spark.executor.extraJavaOptions=-XX:+PrintGCDetails -XX:+PrintGCTimeStamps"


```bash
spark2-submit     --class ClassName --master yarn     --deploy-mode client  --conf spark.driver.maxResultSize=0  --conf "spark.executor.extraJavaOptions=-XX:+UseG1GC "  --conf spark.driver.cores=1     --conf spark.executor.cores=7 --conf spark.yarn.executor.memoryOverhead=3072      --driver-memory 3G     --num-executors 6     --executor-memory 10G   path-to.jar  25
```