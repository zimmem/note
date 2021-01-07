---
tags:
    - java
    - jdk9
---
# JDK 9 Features

## 语法

### 改进 try-with-resources

如果一个可关闭对象(`AutoCloseable`)是 `final` 或等效 `final`， 那么在 `try` 中不需要再重新声明变量

```java
// java 7
BufferedReader br = new BufferedReader(inputString);
try (BufferedReader br1 = br) {
    return br1.readLine();
}

// java 9
BufferedReader br = new BufferedReader(inputString);
try (br) {
    return br.readLine();
}
```

### 改进钻石操作符(Diamond Operator) 

可以在匿名内部类上使用 `<>` 支持泛型。

```java
// java 7 匿名内部类必须写泛型类型
Handler<Integer> intHandler = new Handler<Integer>(1) {
    @Override
    public void handle() {}
};
// java 9 匿名内部类可以自动识别泛型类型
Handler<Integer> intHandler = new Handler<>(1) {
    @Override
    public void handle() {}
};
```

### 私有接口方法

继 JDK 8 给接口加了常量变量及默认("default") 方法后， JDK 9 又给接口添加了私有方法。
```java
public class Tester {
   public static void main(String []args) {
      LogOracle log = new LogOracle();
      log.logInfo("");
      
      LogMySql log1 = new LogMySql();
      log1.logInfo("");
   }
}

final class LogOracle implements Logging { }
final class LogMySql implements Logging { }

interface Logging {
   String ORACLE = "Oracle_Database";
   String MYSQL = "MySql_Database";
 
   private void log(String message, String prefix) {
      getConnection();
      System.out.println("Log Message : " + prefix);
      closeConnection();
   }
   default void logInfo(String message) {
      log(message, "INFO");
   }
   private static void getConnection() {
      System.out.println("Open Database connection");
   }
   private static void closeConnection() {
      System.out.println("Close Database connection");
   }
}
```

## API

### 改进的 Stream API

#### takeWhile
 
当碰到断言为 `false` 后放弃接下来的元素

```java
import java.util.stream.Stream;
 
public class Tester {
   public static void main(String[] args) {
      Stream.of("a","b","c","","e","f").takeWhile(s->!s.isEmpty())
         .forEach(System.out::print);      
   } 
}
// abc
```

#### dropWhile

一直丢弃直到出现第一个断言为 `false` 的元素

```java
import java.util.stream.Stream;
 
public class Tester {
   public static void main(String[] args) {
      Stream.of("a","b","c","","e","f").dropWhile(s-> !s.isEmpty())
         .forEach(System.out::print);
   } 
}
```
#### iterate

使用初始种子值创建顺序, 三个参数分别为 初始值， 断言条件， 生成方式

```java
java.util.stream.IntStream;
 
public class Tester {
   public static void main(String[] args) {
      IntStream.iterate(3, x -> x < 10, x -> x+ 3).forEach(System.out::println);
   } 
}
```
#### ofNullable
ofNullable 方法可以预防 NullPointerExceptions 异常， 可以通过检查流来避免 null 值。

如果指定元素为非 null，则获取一个元素并生成单个元素流，元素为 null 则返回一个空流。
```java
import java.util.stream.Stream;
 
public class Tester {
   public static void main(String[] args) {
      long count = Stream.ofNullable(100).count();
      System.out.println(count);
  
      count = Stream.ofNullable(null).count();
      System.out.println(count);
   } 
}
```

### 改进 Optional 类
### HTTP 2 客户端
### 集合工厂方法
### 改进的 CompletableFuture API
### 轻量级的 JSON API
### 响应式流（Reactive Streams) API
### 改进的弃用注解 @Deprecated
### 多分辨率图像 API
### 进程 API

## JVM

### 模块系统

### REPL (JShell)

### 多版本兼容 JAR 包

### 改进的 Javadoc





[1]:[](https://www.runoob.com/java/java9-new-features.html)