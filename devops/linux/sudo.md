# sudo

## centos 用户加入 sudo 

* 把用户加入 Wheel 组 
```bash
usermod -G wheel $user
```

## sudo 免密码
```bash
sudovi  #编辑配置文件， 把对应的组或用户修改为免密， 如：
%wheel  ALL=(ALL)       NOPASSWD: ALL
``