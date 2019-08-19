# 强制删除 Terminating 状态的 Namespace 

```bash
kubectl get namespace annoying-namespace-to-delete -o json > tmp.json

# delete spac   field in json file

curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json https://kubernetes-cluster-ip/api/v1/namespaces/annoying-namespace-to-delete/finalize
```

有时用上面方法还不能删除， 可以用下面命令找下 ns 下还有哪些资源， 并删掉
```bash
kubectl api-resources --verbs=list --namespaced -o name \
  | xargs -n 1 kubectl get --show-kind --ignore-not-found 
```