#!/bin/bash

# clone helper xibc-contracts
cd ../helper

# download helper
function download_xibc() {
  if [ ! -d "xibc-contracts/" ];then
    echo "文件夹不存在"
    git clone git@github.com:teleport-network/xibc-contracts.git
    cd xibc-contracts
    git checkout  auto-deploy
    cd evm && yarn && yarn compile
    mv  hardhat.config.ts hardhat.config.bak.ts
    cd ../erc20 && yarn && yarn compile
    mv  hardhat.config.ts hardhat.config.bak.ts

    # exit to pre path
    cd ../../../  &&  echo $PWD

    # replace config
    cp -r eth-tele/hardhat-config/hardhat.config.erc20.ts helper/xibc-contracts/erc20/hardhat.config.ts \
    && cp -r eth-tele/hardhat-config/hardhat.config.evm.ts helper/xibc-contracts/evm/hardhat.config.ts

    # recompile for build error
    cd helper/xibc-contracts/evm && yarn compile
    cd ../erc20 && yarn compile
    cd ../../
  else
    echo "文件夹存在"
  fi
}

function update_env(){
  source ../eth-tele/env_var/variable.sh
}

function tool_check() {
  while true; do
  yarn hardhat deployLibraries --network $ETH_NETWORK_NAME
  grep $1 env.txt
  if [ "$?" = "0" ]; then
    break
  fi
  done
  echo "deploy $1 success!"
  source env.txt
}

function deploy_base_on_eth() {
    echo "wenbin"
    cd xibc-contracts/evm

    tool_check LIGHT_CLIENT_GEN_VALHASH_ADDRESS
}

download_xibc

update_env

deploy_base_on_eth


# exit to pre path
cd ../eth-tele