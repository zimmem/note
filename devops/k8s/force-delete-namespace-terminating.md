# 强制删除 Terminating 状态的 Namespace 

```bash
kubectl get namespace annoying-namespace-to-delete -o json > tmp.json

# delete spac   field in json file

curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json https://kubernetes-cluster-ip/api/v1/namespaces/annoying-namespace-to-delete/finalize
```