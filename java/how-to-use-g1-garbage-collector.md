# How to use G1 garbage collector

| 参数 | 描述 |
| :--- | :--- |
| -XX:+UseG1GC | 开启G1 |
| -XX:MaxGCPauseMillis=n | 设置GC暂停的最大时间,这只是目标,尽量达到,默认值是 200 毫秒,过小影响吞吐量 |
| -XX:InitiatingHeapOccupancyPercent=n | 整个堆\(而不是某个年代\)使用量达到此值,便会触发并发GC周期.值为0则是连续触发,默认值为45 |
| -XX:NewRatio=n | 老年代与新生代的比值,默认值为2 |
| -XX:SurvivorRatio=n | 伊甸园代与生存代的比率,默认值为8 |
| -XX:MaxTenuringThreshold=n | 生存代存活的最大门限,默认值为15 |
| -XX:ParallelGCThreads=n | 设置垃圾回收器并行阶段的线程数,默认值与JVM运行的平台有关,将 n 的值设置为逻辑处理器的数量 |
| -XX:ConcGCThreads=n | 设置并发垃圾回收器使用的线程数,默认值与JVM运行的平台有关 |
| -XX:G1ReservePercent=n | 设置剩余的内存量,减少跃迁失败的可能,默认值为10 |
| -XX:G1HeapRegionSize=n | 设置G1平分java堆而产生区域的大小,默认值可以提供最大的工效性.最小值为1M,最大为32M,最多划分1024个,建议使用默认值 |



