# 在 kubernetes 上搭建 hyperledger-fabric

## 修改 K8S 结点 DNS 配置

两种方法， 

* 修改 docker 启动参数
* 修改结点 /etc/resolv.conf

## 创建 namespace

```bash
declare -a arr=("fabric-orderer" "fabric-org-1" "fabric-org-2")
for i in "${arr[@]}"
do
   kubectl create namespace $i
done
```

## 创建共享 Volumn

为方便 pod 间共享文件， 使用  nfs-volumn


```bash
# read line with space
IFS=''
declare -a arr=("default" "fabric-orderer" "fabric-org-1" "fabric-org-2")
nfs_server=10.100.240.76
for ns in "${arr[@]}"
do
echo "
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-fabric-dev-for-${ns}
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 10Gi
  nfs:
    path: /
    server: ${nfs_server}

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: fabric-pvc-for-${ns}
  namespace: ${ns}
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 3Gi
  storageClassName: ""
  volumeName: nfs-fabric-dev-for-${ns}

" | kubectl create -f -
done 
```

##  搭建 fabric-tools 

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    name: fabric-tools
  name: fabric-tools
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      name: fabric-tools
  template:
    metadata:
      labels:
        name: fabric-tools
    spec:
      containers:
      - args:
        - sleep
        - "999999999"
        image: registry.docker-cn.com/hyperledger/fabric-tools:x86_64-1.1.0
        name: fabric-tools
        volumeMounts:
        - mountPath: /etc/hyperledger/fabric
          name: fabric-config
      volumes:
      - name: fabric-config
        persistentVolumeClaim:
          claimName: fabric-pvc-for-default
```

## 生成配置文件
一个 orderer 结点 ， 两个组织， 每个组织两个 peer

进入 fabric-tool pod 的 bash
```bash
kubectl exec -it fabric-tools-xxx bash
```

创建 crypto-config.yaml 并生成配置文件

```bash
cat > /etc/hyperledger/fabric/crypto-config.yaml <<EOF
OrdererOrgs:
  - Name: Orderer
    Domain: fabric-orderer
    Specs:
      - Hostname: orderer

PeerOrgs:
  - Name: Org1
    Domain: fabric-org-1
    Template:
      Count: 2
    Users:
      Count: 2
  - Name: Org2
    Domain: fabric-org-2
    Template:
      Count: 2
    Users:
      Count: 2
EOF
cryptogen generate --config /etc/hyperledger/fabric/crypto-config.yaml --output /etc/hyperledger/fabric/crypto-config
```

创建 /etc/hyperledger/fabric/configtx.yaml 文件
> 参考 https://raw.githubusercontent.com/hyperledger/fabric/v1.1/examples/e2e_cli/configtx.yaml


```yaml
Profiles:
    TwoOrgsOrdererGenesis:
        Orderer:
            <<: *OrdererDefaults
            Organizations:
                - *OrdererOrg
            Capabilities:
                <<: *OrdererCapabilities
        Consortiums:
            SampleConsortium:
                Organizations:
                    - *Org1
                    - *Org2
    TwoOrgsChannel:
        Consortium: SampleConsortium
        Application:
            <<: *ApplicationDefaults
            Organizations:
                - *Org1
                - *Org2
            Capabilities:
                <<: *ApplicationCapabilities
Organizations:
    - &OrdererOrg
        Name: OrdererOrg
        ID: OrdererMSP
        AdminPrincipal: Role.ADMIN
        MSPDir: crypto-config/ordererOrganizations/fabric-orderer/msp
    - &Org1
        Name: Org1MSP
        ID: Org1MSP
        MSPDir: crypto-config/peerOrganizations/fabric-org-1/msp
        AdminPrincipal: Role.ADMIN
        AnchorPeers:
            - Host: peer0.fabric-org-1
              Port: 7051
    - &Org2
        Name: Org2MSP
        ID: Org2MSP
        MSPDir: crypto-config/peerOrganizations/fabric-org-2/msp
        AdminPrincipal: Role.ADMIN
        AnchorPeers:
            - Host: peer0.fabric-org-2
              Port: 7051
Orderer: &OrdererDefaults
    OrdererType: kafka
    Addresses:
        - orderer.fabric-orderer:7050
    BatchTimeout: 2s
    BatchSize:
        MaxMessageCount: 10
        AbsoluteMaxBytes: 98 MB
        PreferredMaxBytes: 512 KB
    Kafka:
        Brokers:
            - kafka-service.default:9092
    Organizations:
Application: &ApplicationDefaults
    Organizations:
Capabilities:
    Global: &ChannelCapabilities
        V1_1: true
    Orderer: &OrdererCapabilities
        V1_1: true
    Application: &ApplicationCapabilities
        V1_1: true

```

生成创世区块
```
cd /etc/hyperledger/fabric
configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./crypto-config/ordererOrganizations/fabric-orderer/orderers/orderer.fabric-orderer/orderer.genesis.block
```


```bash
CHANNEL_NAME=test-channel

# 生成 channel
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./${CHANNEL_NAME}.tx -channelID ${CHANNEL_NAME}

# 生成 org1, org2 的锚点文件
configtxgen \
    -profile TwoOrgsChannel \
    -outputAnchorPeersUpdate ./Org1MSPanchors.tx \
    -channelID ${CHANNEL_NAME} \
    -asOrg Org1MSP 

configtxgen \
    -profile TwoOrgsChannel \
    -outputAnchorPeersUpdate ./Org2MSPanchors.tx \
    -channelID ${CHANNEL_NAME} \
    -asOrg Org2MSP
```

## 搭建 orderer 结点

把 configtx.yaml 复制到 /etc/hyperledger/fabric/crypto-config/ordererOrganizations/fabric-orderer/orderers/orderer.fabric-orderer/configtx.yaml

创建 /etc/hyperledger/fabric/crypto-config/ordererOrganizations/fabric-orderer/orderers/orderer.fabric-orderer/orderer.yaml
> 参考 https://github.com/hyperledger/fabric/blob/v1.1.0/sampleconfig/orderer.yaml

```yaml
General:
    LedgerType: file
    ListenAddress: 127.0.0.1
    ListenPort: 7050
    TLS:
        Enabled: false
        PrivateKey: tls/server.key
        Certificate: tls/server.crt
        RootCAs:
          - tls/ca.crt
        ClientAuthRequired: false
        ClientRootCAs:
    Keepalive:
        ServerMinInterval: 60s
        ServerInterval: 7200s
        ServerTimeout: 20s
    LogLevel: info
    LogFormat: '%{color}%{time:2006-01-02 15:04:05.000 MST} [%{module}] %{shortfunc} -> %{level:.4s} %{id:03x}%{color:reset} %{message}'
    GenesisMethod: provisional
    GenesisProfile: TwoOrgsOrdererGenesis
    GenesisFile: orderer.genesis.block
    LocalMSPDir: msp
    LocalMSPID: DEFAULT
    Profile:
        Enabled: false
        Address: 0.0.0.0:6060
    BCCSP:
        Default: SW
        SW:
            Hash: SHA2
            Security: 256
            FileKeyStore:
                KeyStore:
    Authentication:
        TimeWindow: 15m
FileLedger:
    Location: /var/hyperledger/production/orderer
    Prefix: hyperledger-fabric-ordererledger
RAMLedger:
    HistorySize: 1000
Kafka:
    Retry:
        ShortInterval: 5s
        ShortTotal: 10m
        LongInterval: 5m
        LongTotal: 12h
        NetworkTimeouts:
            DialTimeout: 10s
            ReadTimeout: 10s
            WriteTimeout: 10s
        Metadata:
            RetryBackoff: 250ms
            RetryMax: 3
        Producer:
            RetryBackoff: 100ms
            RetryMax: 3
        Consumer:
            RetryBackoff: 2s
    Verbose: false
    TLS:
      Enabled: false
      PrivateKey:
      Certificate:
      RootCAs:
    Version:
Debug:
    BroadcastTraceDir:
    DeliverTraceDir:
```

hyperledger/fabric-orderer


```yaml
apiVersion: v1
kind: Service
metadata:
  name: orderer
  namespace: fabric-orderer
spec:
  ports:
  - name: tcp-7050
    port: 7050
    protocol: TCP
    targetPort: 7050
  selector:
    name: fabric-orderer

---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    name: fabric-orderer
  name: fabric-orderer
  namespace: fabric-orderer
spec:
  replicas: 1
  selector:
    matchLabels:
      name: fabric-orderer
  template:
    metadata:
      labels:
        name: fabric-orderer
    spec:
      containers:
      - args:
        - orderer
        - start
        image: registry.docker-cn.com/hyperledger/fabric-orderer:x86_64-1.1.0
        name: fabric-orderer
        env:
        - name: ORDERER_GENERAL_LISTENADDRESS
          value: 0.0.0.0
        - name: ORDERER_GENERAL_TLS_ENABLED
          value: "true"
        - name: ORDERER_GENERAL_TLS_ROOTCAS
          value: "[/etc/hyperledger/fabric/tls/ca.crt,/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/ca/ca.fabric-org-1-cert.pem,/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-2/ca/ca.fabric-org-2-cert.pem]"
        - name: ORDERER_GENERAL_LOCALMSPID
          value: OrdererMSP
        - name: ORDERER_GENERAL_LOCALMSPDIR
          value: /etc/hyperledger/fabric/msp
        volumeMounts:
        - mountPath: /etc/hyperledger/fabric/
          name: fabric-config
          subPath: crypto-config/ordererOrganizations/fabric-orderer/orderers/orderer.fabric-orderer
        - mountPath: /etc/hyperledger/fabric/crypto-config
          name: fabric-config
          subPath: crypto-config
      volumes:
      - name: fabric-config
        persistentVolumeClaim:
          claimName: fabric-pvc-for-fabric-orderer
          
```


## 搭建 peer 结点



```bash
IFS=''
declare -a orgIds=("1" "2")
for org_id in "${orgIds[@]}"
do
    namespace=fabric-org-${org_id}
    declare -a peers=("peer0" "peer1")
    for peer in "${peers[@]}"
    do
        echo "apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  namespace: $namespace
  name: fabric-$peer
spec:
  replicas: 1
  template:
    metadata:
      labels:
        name: fabric-$peer
    spec:
      containers:
      - name: couchdb
        image: registry.docker-cn.com/hyperledger/fabric-couchdb:x86_64-1.0.0
        ports:
         - containerPort: 5984

      - name: peer
        image: registry.docker-cn.com/hyperledger/fabric-peer:x86_64-1.1.0
        env:
        - name: CORE_LEDGER_STATE_STATEDATABASE
          value: \"CouchDB\"
        - name: CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS
          value: \"localhost:5984\"
        - name: CORE_VM_ENDPOINT
          value: \"unix:///host/var/run/docker.sock\"
        - name: CORE_LOGGING_LEVEL
          value: \"DEBUG\"
        - name: CORE_PEER_TLS_ENABLED
          value: \"false\"
        - name: CORE_PEER_GOSSIP_USELEADERELECTION
          value: \"true\"
        - name: CORE_PEER_GOSSIP_ORGLEADER
          value: \"false\" 
        - name: CORE_PEER_PROFILE_ENABLED
          value: \"true\"
        - name: CORE_PEER_TLS_CERT_FILE
          value: \"/etc/hyperledger/fabric/tls/server.crt\" 
        - name: CORE_PEER_TLS_KEY_FILE
          value: \"/etc/hyperledger/fabric/tls/server.key\"
        - name: CORE_PEER_TLS_ROOTCERT_FILE
          value: \"/etc/hyperledger/fabric/tls/ca.crt\"
        - name: CORE_PEER_ID
          value: $peer.$namespace
        - name: CORE_PEER_ADDRESS
          value: 0.0.0.0:7051
        - name: CORE_PEER_GOSSIP_EXTERNALENDPOINT
          value: $peer.$namespace:7051
        - name: CORE_PEER_LOCALMSPID
          value: Org${org_id}MSP
        ports:
         - containerPort: 7051
         - containerPort: 7052
         - containerPort: 7053
        command: [\"peer\"]
        args: [\"node\",\"start\"]
        volumeMounts:
         - mountPath: /etc/hyperledger/fabric/msp 
           name: certificate
           subPath: crypto-config/peerOrganizations/$namespace/peers/$peer.$namespace/msp
         - mountPath: /etc/hyperledger/fabric/tls
           name: certificate
           subPath: crypto-config/peerOrganizations/$namespace/peers/$peer.$namespace/tls
         - mountPath: /host/var/run/
           name: run
      volumes:
       - name: certificate
         persistentVolumeClaim:
             claimName: fabric-pvc-for-$namespace
       - name: run
         hostPath:
           path: /run
       

---
apiVersion: v1
kind: Service
metadata:
   namespace: $namespace
   name: $peer
spec:
 selector:
   name: fabric-$peer
 ports:
   - name: externale-listen-endpoint
     protocol: TCP
     port: 7051
     targetPort: 7051

   - name: chaincode-listen
     protocol: TCP
     port: 7052
     targetPort: 7052

---
" | kubectl create  -f - 
    done
done
```


## 运行示例 chaincode

### 创建 test-channel, 并把所有 peer 加入

进入 fabric-tools pod 执行

```bash
CHANNEL_NAME=test-channel
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp
peer channel create \
    -o orderer.fabric-orderer:7050 \
    -c ${CHANNEL_NAME} \
    -f test-channel.tx 
# 创建成功本地生成 test-channel.block



# 把4个结点都加入 channel
declare -a orgIds=("1" "2")
for org_id in "${orgIds[@]}"
do
    orgDomain=fabric-org-${org_id}
    declare -a peers=("peer0" "peer1")
    for peer in "${peers[@]}"
    do
    export CORE_PEER_LOCALMSPID="Org${org_id}MSP" 
    export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/${orgDomain}/users/Admin@${orgDomain}/msp 
    export CORE_PEER_ADDRESS=$peer.${orgDomain}:7051
    peer channel join -b test-channel.block
    done
done


# 更新两个组织的锚点信息
export CORE_PEER_LOCALMSPID="Org1MSP" 
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp 
export CORE_PEER_ADDRESS=peer0.fabric-org-1:7051
peer channel update -o orderer.fabric-orderer:7050 \
    -c test-channel \
    -f Org1MSPanchors.tx

export CORE_PEER_LOCALMSPID="Org2MSP" 
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-2/users/Admin@fabric-org-2/msp 
export CORE_PEER_ADDRESS=peer0.fabric-org-2:7051
peer channel update -o orderer.fabric-orderer:7050 \
    -c test-channel \
    -f Org2MSPanchors.tx
```

## 测试网络

```bash


export CORE_PEER_LOCALMSPID="Org1MSP" 
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp 
export CORE_PEER_ADDRESS=peer0.fabric-org-1:7051

#下载 hyperledger/fabric 源码
git clone https://github.com/hyperledger/fabric.git /opt/gopath/src/github.com/hyperledger/fabric

# 安装测试链码
peer chaincode install \
    -n test-cc \
    -v 1.0 \
    -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02

# 实例化链码
# a 初始余额为 100
# b 初始余额为 200
peer chaincode instantiate \
    -o orderer.fabric-orderer:7050 \
    -C test-channel \
    -n test-cc \
    -v 1.0 \
    -c '{"Args":["init","a","100","b","200"]}' \
    -P "OR('Org1MSP.member','Org2MSP.member')"

# 执行链码
# 从 a 的余额里转 10 到 b
peer chaincode invoke \
    -o orderer.fabric-orderer:7050 \
    -C test-channel \
    -n test-cc \
    -c '{"Args":["invoke","a","b","10"]}'

# 查询 a 的余额
peer chaincode query \
    -C test-channel \
    -n test-cc \
    -c '{"Args":["query","a"]}'

# 查询 b 的余额
peer chaincode query \
    -C test-channel \
    -n test-cc \
    -c '{"Args":["query","b"]}'
```