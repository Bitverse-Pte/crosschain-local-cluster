#!/bin/bash

function update_env(){
  source env_var/variable.sh
}

function hardhat_deploy(){
  if [ "$1" = "LIGHT_CLIENT_GEN_VALHASH_ADDRESS" ]; then
    yarn hardhat deployLibraries --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "ACCESS_MANAGER_ADDRESS" ]; then
    yarn hardhat deployAcessManager --network $ETH_NETWORK_NAME --wallet $SUPER_ADMIN
  fi
}

function tool_check() {
  temp=0
  while true; do
    temp=`expr $temp + 1`
    echo $temp

    # loop 5 times, or break
    if [ "$temp" = "5" ]; then
      break
    fi

    # deploy
    hardhat_deploy $1
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
    cd ../helper/xibc-contracts/evm

    tool_check LIGHT_CLIENT_GEN_VALHASH_ADDRESS
    tool_check ACCESS_MANAGER_ADDRESS
}


update_env

deploy_base_on_eth

# exit to pre path
cd  ../../../eth-tele