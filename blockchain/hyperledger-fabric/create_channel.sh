创建通道


CHANNEL_NAME=test-channel
export CORE_LOGGING_LEVEL=debug
export CORE_PEER_ADDRESS=peer0.fabric-org-1:7051
CHANNEL_NAME=test-channel
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp
peer channel create \
    -o orderer.fabric-orderer:7050 \
    -c ${CHANNEL_NAME} \
    -f test-channel.tx 

    
peer channel list \
    -o orderer.fabric-orderer:7050 \
    --tls \
    --cafile /etc/hyperledger/fabric/crypto-config/ordererOrganizations/fabric-orderer/orderers/orderer.fabric-orderer/msp/tlscacerts/tlsca.fabric-orderer-cert.pem 


export CORE_PEER_PROFILE_ENABLED=true
export CORE_PEER_GOSSIP_ORGLEADER=false
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_TLS_ENABLED=false
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/peerOrganizations/fabric-org-1/users/Admin@fabric-org-1/msp
export CORE_LOGGING_LEVEL=DEBUG


export CORE_PEER_LOCALMSPID="OrdererMSP"
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto-config/ordererOrganizations/fabric-orderer/users/Admin@fabric-orderer/msp
peer channel create \
    -o orderer.fabric-orderer:7050 \
    -c ${CHANNEL_NAME} \
    -f test-channel.tx 