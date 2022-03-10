#!/bin/bash

function clear_pre_config(){
  rm -rf ~/.teleport-relayer/
  ## generate new files
  relayer init
}

function create_client_on_bsc(){
  source env_var/bsctest.txt

  # remove pre files
  relayer genFiles tendermint teleport teleport_7001-1 $TELE_CHAIN_URL_9090 $TM_CLIENT_HEIGHT

  cd ../helper/xibc-contracts/evm
  yarn hardhat createClientFromFile  --chain teleport --client $TENDERMINT_CLIENT \
    --clientstate  ~/.teleport-relayer/tendermint_clientState.txt \
    --consensusstate ~/.teleport-relayer/tendermint_consensusState.txt \
    --network $BSC_NETWORK_NAME

  yarn hardhat registerRelayer  --chain teleport  --relayer  $BSC_RELAYER  \
   --network $BSC_NETWORK_NAME

  cd ../../../qa

  echo "success"
}

function create_client_on_eth(){
  source env_var/rinkeby.txt

  cd ../helper/xibc-contracts/evm

  # part-pubkey doesn't need to change
  yarn hardhat createTssCLient --chain teleport  \
  --client $TSS_CLIENT   \
  --pubkey 0xce03272bced9049b1fe60dc7f4e90a94b7949f13ed708fe150fb8daf1bc75bd4a2fe4d8c671e20073d72e9a53148fd92f8b8a74a48e15ee3baf9d6bf213317ff  \
  --partpubkeys [0x42417732b0e10b29aa8c5284c58136ac6726cbc1b5afc8ace6d6c4b03274cd01310b958a6dc5b27f2c1ad5c6595bffeac951c8407947d05166e687724d3890f7,0xa926c961ab71a72466faa6abef8074e6530f4c56087c43087ab92da441cbb1e9d24dfc12a5e0b4a686897e50ffa9977b3c3eb13870dcd44335287c0777c71489,0xc17413bbdf839a3732af84f61993c9a09d71f33a68f6fbf05ce53b66b0954929943184d65d8d02c11b7a70904805bcca6e3f3749d95e6438b168f2ed55768310,0x28b5ba326397f2c0f689908bcf4fe198d842739441471fa96e43d4cdd495d9c9f138fed315b3744300fa1dd5599a9e21d12264f97b094f3a5f4b84be120a1c6a] \
  --pooladdress 0xf822ec5c3a4142fb33d3e1ebbcb99dd50c1e6d1e  --network $ETH_NETWORK_NAME
}

function  voteProposal(){
  for ((i=0; i<=10; i++))
  do
    teleport tx gov vote $1 yes  \
    --from validator$i --home ~/teleport_testnet/validator$i/teleport \
    --keyring-backend test --keyring-dir  ~/teleport_testnet/validator$i/teleport \
     --chain-id teleport_7001-1  -b block --fees 25000000000000000000atele\
     --node $TELE_CHAIN_URL_26657 -y
  done
}


function voting() {
    # vote proposal-id 1
    voteProposal $1

    sleep $VOTING_PERIOD
}

function create_bsc_client_on_tele(){
  source env_var/bsctest.txt
  source env_var/qa_tele.txt

  sudo rm -rf ~/teleport_testnet/
  cp -r ../helper/teleport ~/teleport_testnet/
#
#  relayer genFiles bsc $BSC_CHAIN_NAME $BSC_CHAIN_ID $BSC_CHAIN_URL --packet $PACKET_ADDRESS
#
#  teleport tx gov submit-proposal client-create \
#  bsc-testnet ~/.teleport-relayer/bsc-testnet_clientState.json ~/.teleport-relayer/bsc-testnet_consensusState.json \
#  --from validator0 --home ~/teleport_testnet/validator0/teleport \
#  --keyring-backend test --keyring-dir ~/teleport_testnet/validator0/teleport \
#   --chain-id teleport_7001-1 --deposit 2000000000000000000000atele \
#    -y -b block --title "test" --description "test"  \
#    --gas auto --fees 25000000000000000000atele --node $TELE_CHAIN_URL_26657
#
#  voting 1


  teleport tx gov submit-proposal relayer-register bsc-testnet \
   teleport1q3nyjegjg23ar2hlhlpx3zm7cmyhdh49pyz5yd  \
   --from validator0 --home ~/teleport_testnet/validator0/teleport \
   --keyring-backend test --keyring-dir ~/teleport_testnet/validator0/teleport  \
   --chain-id teleport_7001-1 --deposit  200000000000000000000atele  \
   -y -b block --title "test" --description "test"    \
   --node $TELE_CHAIN_URL_26657 \
   --gas auto  --fees 250000000000000000atele

  voting 6


  echo "success"
}

function create_eth_client_on_tele(){
  source env_var/rinkeby.txt
  source env_var/qa_tele.txt
#
#  relayer genFiles eth $ETH_CHAIN_NAME $ETH_CHAIN_ID $ETH_CHAIN_URL --packet $PACKET_ADDRESS
#
#  teleport tx gov submit-proposal client-create \
#  rinkeby ~/.teleport-relayer/rinkeby_clientState.json ~/.teleport-relayer/rinkeby_consensusState.json \
#  --from validator0 --home ~/teleport_testnet/validator0/teleport \
#  --keyring-backend test --keyring-dir ~/teleport_testnet/validator0/teleport \
#   --chain-id teleport_7001-1 --deposit 2000000000000000000000atele \
#    -y -b block --title "test" --description "test"  \
#    --gas auto --fees 25000000000000000000atele --node $TELE_CHAIN_URL_26657
#
#  voting 3


  teleport tx gov submit-proposal relayer-register rinkeby \
   teleport1adtdq74lrg22lrmzj6ht9w6d0ef20n6xy547t0  \
   --from validator0 --home ~/teleport_testnet/validator0/teleport \
   --keyring-backend test --keyring-dir ~/teleport_testnet/validator0/teleport  \
   --chain-id teleport_7001-1 --deposit  200000000000000000000atele  \
   -y -b block --title "test" --description "test"    \
   --node $TELE_CHAIN_URL_26657 \
   --gas auto  --fees 250000000000000000atele

  voting 7

}

function query_proposals(){
  teleport q gov proposals --node $TELE_CHAIN_URL_26657
}

# clear_pre_config

create_client_on_bsc

#create_client_on_eth
#
#create_bsc_client_on_tele
#create_eth_client_on_tele

