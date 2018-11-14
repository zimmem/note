# saved_model




## 使用 saved_model_cli 检查及执行 saved_model

[CLI to inspect and execute SavedModel]

### 查看 saved_model 详情
``` bash
# 查看有哪些  tag-sets
saved_model_cli show --dir /tmp/saved_model_dir

# 查看 tag-set 里有哪些 SignatureDef
saved_model_cli show --dir /tmp/saved_model_dir --tag_set serve

# 查看一个具体的 signature_def 详情
saved_model_cli show \
    --dir /tmp/saved_model_dir --tag_set serve \
    --signature_def serving_default

# 查看所有信息
saved_model_cli show --dir /tmp/saved_model_dir --all
```

### 执行 saved_model
[saved_model#run_command]


<div style="display:none;">
### 把 checkpoint 转成 saved_model
[Serving Inception Model with TensorFlow Serving and Kubernetes]

可以用链接中写的脚本， 或者直接 docker run 

```bash
docker run --rm -it --network=host    -v D:\models\inception-v3\:/models/inception registry.docker-cn.com/tensorflow/serving:nightly-devel  bash

# in docker container
bazel build -c opt \
    tensorflow_serving/example:inception_saved_model

bazel-bin/tensorflow_serving/example/inception_saved_model \
  --checkpoint_dir=inception-v3 --output_dir=models/inception
```
</div>




[TensorFlow saved_model 模块]: https://blog.csdn.net/thriving_fcl/article/details/75213361
[CLI to inspect and execute SavedModel]: https://www.tensorflow.org/guide/saved_model#cli_to_inspect_and_execute_savedmodel
[saved_model#run_command]: https://www.tensorflow.org/guide/saved_model#run_command

[Serving Inception Model with TensorFlow Serving and Kubernetes]: https://www.tensorflow.org/serving/serving_inception