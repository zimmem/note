# RabbitMQ

[RabbitMQ及Erlang内存使用分析](https://blog.csdn.net/jaredcoding/article/details/78115235)

[rabbitmq 3.6.2 内存持续增长问题](https://www.cnblogs.com/oolo/p/6023803.html)

```
rabbitmqctl eval 'supervisor2:terminate_child(rabbit_mgmt_sup_sup, rabbit_mgmt_sup),rabbit_mgmt_sup_sup:start_child().'
```