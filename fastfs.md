# Spark DataFrame Join

Prepare Data

```scala
case class Person(id:Int, name:String)
case class Info(id:Int, age:Int)

val personDF = sc.makeRDD(Seq(Person(1,"A"), Person(2, "B"))).toDF("id", "name")
val infoDF = sc.makeRDD(Seq(Info(1,11), Info(3, 33))).toDF("id", "age")
```

samples 

1. just join

    ```scala
    personDF.join(infoDF).show()
    
    +---+----+---+---+
    | id|name| id|age|
    +---+----+---+---+
    |  1|   A|  1| 11|
    |  1|   A|  3| 33|
    |  2|   B|  1| 11|
    |  2|   B|  3| 33|
    +---+----+---+---+
    ```

2. join using column
    
    ```
    personDF.join(infoDF, "id").show()
    
    +---+----+---+                                                                  
    | id|name|age|
    +---+----+---+
    |  1|   A| 11|
    +---+----+---+

    ```

3. left outer join

    ```
    personDF.join(infoDF, Seq("id"), "left_outer" ).show()
    
    +---+----+----+                                                                 
    | id|name| age|
    +---+----+----+
    |  1|   A|  11|
    |  2|   B|null|
    +---+----+----+
    ```

4. outer join

    ```
    personDF.join(infoDF, Seq("id"), "outer" ).show()
    
    +---+----+----+                                                                 
    | id|name| age|
    +---+----+----+
    |  1|   A|  11|
    |  2|   B|null|
    |  3|null|  33|
    +---+----+----+

    ```
    
5. right outer join

    ```
    personDF.join(infoDF, Seq("id"), "right_outer" ).show()
    
    +---+----+---+                                                                  
    | id|name|age|
    +---+----+---+
    |  1|   A| 11|
    |  3|null| 33|
    +---+----+---+
    ```

