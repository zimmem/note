# npm 配置 registry 镜像或代理

## 配置 registry 镜像

* 命令行配置
  ```
  npm config set registry http://registry.cnpmjs.org
  npm info underscore （如果上面配置正确这个命令会有字符串response）
  ```
* 命令行指定
  ```
  npm --registry http://registry.cnpmjs.org info underscore
  ```
* 编辑 ~/.npmrc 
  ```
  registry = http://registry.cnpmjs.org
  ```

## 配置代理



```
npm config set proxy http://server:port
npm config set https-proxy http://server:port
```

或

```
npm config set proxy http://username:password@server:port
npm confit set https-proxy http://username:password@server:port
```

## 使用 nrm 快速切换npm源

### 安装

```
sudo npm install -g nrm
```

### 使用

列出可用的源：

```
~  nrm ls
  npm ---- https://registry.npmjs.org/
  cnpm --- http://r.cnpmjs.org/
  taobao - http://registry.npm.taobao.org/
  eu ----- http://registry.npmjs.eu/
  au ----- http://registry.npmjs.org.au/
  sl ----- http://npm.strongloop.com/
  nj ----- https://registry.nodejitsu.com/
  pt ----- http://registry.npmjs.pt/
```



