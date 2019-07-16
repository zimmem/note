# 常见问题

## 创建 notebook 时创建 pod 不成功

通过 `kubectl describe   statefulset.apps/test` 查看原因：
```
create Pod test-0 in StatefulSet test failed error: pods "test-0" is forbidden: pod.Spec.SecurityContext.FSGroup is forbidden
```
解决办法： 把 kube-apiserver 启动参数`--enable-admission-plugins` 中的 `SecurityContextDeny` 去掉