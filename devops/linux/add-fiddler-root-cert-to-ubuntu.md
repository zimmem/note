# 在 ubuntu 中添加 fiddler 证书

1. 从fiddler 中导出根证书到桌面
2. 把证书转换下格式
   
   ```bash
   openssl x509 -inform DER -in FiddlerRoot.cer  -out FiddlerRoot.pem
   ```

3. 拷贝到证书目录并更新
   ```bash
   sudo cp FiddlerRoot.pem  /etc/ssl/certs
   sudo update-ca-certificates
   ```