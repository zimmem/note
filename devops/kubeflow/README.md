# kubeflow

[轻松扩展你的机器学习能力 ： Kubeflow](https://zhuanlan.zhihu.com/p/44692757)
[Katib: Kubernetes native 的超参数训练系统](https://zhuanlan.zhihu.com/p/36495583)


## install

https://www.kubeflow.org/docs/started/getting-started/
https://www.kubeflow.org/docs/started/k8s/kfctl-k8s-istio/

```bash
kfctl generate k8s

## 执行前先在目录下 sed -i 's/gcr.io/gcr.azk8s.cn/g' 把镜像的 registry 先改一下
kfctl apply k8s -V
```
