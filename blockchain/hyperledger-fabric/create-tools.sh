org_id=1
namespace=fabric-org-${org_id}

echo "
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  namespace: $namespace
  name: fabric-tools
spec:
  replicas: 1
  template:
    metadata:
      labels:
        name: fabric-tools
    spec:
      containers:
      - name: fabric-tools
        image: registry.docker-cn.com/hyperledger/fabric-tools:x86_64-1.1.0
        env:
        - name: CORE_LOGGING_LEVEL
          value: \\"DEBUG\\"
        - name: CORE_PEER_TLS_ENABLED
          value: \\"false\\"
        - name: CORE_PEER_GOSSIP_ORGLEADER
          value: \\"false\\" 
        - name: CORE_PEER_PROFILE_ENABLED
          value: \\"true\\"
        - name: CORE_PEER_LOCALMSPID
          value: Org${org_id}MSP
        - name: CORE_PEER_MSPCONFIGPATH
          value: /etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp
        command: [ \"/bin/bash\", \"-c\", \"--\" ]
        args: [ \"while true; do sleep 30; done;\" ]
        volumeMounts:
         - mountPath: /etc/hyperledger/fabric/crypto-config 
           name: certificate
           subPath: crypto-config
      volumes:
       - name: certificate
         persistentVolumeClaim:
             claimName: fabric-pvc-for-$namespace
" | kubectl create -f -