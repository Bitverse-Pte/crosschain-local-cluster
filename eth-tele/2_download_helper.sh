#!/bin/bash

# clone helper xibc-contracts
cd ../helper

# download helper
function download_xibc() {
  if [ ! -d "xibc-contracts/" ];then
    echo "文件夹不存在"
    git clone git@github.com:teleport-network/xibc-contracts.git
    cd xibc-contracts
    git checkout $XIBC_CONTRACTS_BRANCH
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


download_xibc

cd ../eth-tele