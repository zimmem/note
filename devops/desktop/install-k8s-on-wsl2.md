# 在 Wsl2 中安装单机 k8s

前置条件： 已经在 wsl 安装了 ubuntu 发行版， 本文安装的是 20.04 版本

## 安装Docker 
```bash
# step 1: 安装必要的一些系统工具
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce
```

## 安装  genie  支持在 wsl2 中启动 systemd

> [https://blog.batkiz.com/posts/2019/lets-roll-to-wsl2/](https://blog.batkiz.com/posts/2019/lets-roll-to-wsl2/)

安装 dotnet-runtime-3.0
> [Ubuntu 20.04 Package Manager - Install .NET Core](https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-2004)

```bash
# Add Microsoft repository key and feed
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Install the .NET Core SDK
sudo apt-get update
sudo apt-get install dotnet-runtime-3.1

```

安装 genie
```bash
# install repository
curl -s https://packagecloud.io/install/repositories/arkane-systems/wsl-translinux/script.deb.sh | sudo bash
# install genie

```

## 安装 kubernetes

## 配置代理支持 windows 应用访问

