# npm 配置 registry 镜像或代理

## 配置 registry 镜像

* 命令行配置
* ```
  npm config set registry http://registry.cnpmjs.org
  npm info underscore （如果上面配置正确这个命令会有字符串response）
  ```
* 命令行指定
* ```
  npm --registry http://registry.cnpmjs.org info underscore
  ```
* 编辑 ~/.npmrc 
* ```
  registry = http://registry.cnpmjs.org
  ```



## 配置代理



