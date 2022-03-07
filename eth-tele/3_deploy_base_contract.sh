#!/bin/bash

function update_env(){
  source env_var/variable.sh
}

function hardhat_deploy_base(){
  if [ "$1" = "LIGHT_CLIENT_GEN_VALHASH_ADDRESS" ]; then
    yarn hardhat deployLibraries --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "ACCESS_MANAGER_ADDRESS" ]; then
    yarn hardhat deployAcessManager --network $ETH_NETWORK_NAME --wallet $SUPER_ADMIN
  fi

  if [ "$1" = "CLIENT_MANAGER_ADDRESS" ]; then
    yarn hardhat deployClientManager --network $ETH_NETWORK_NAME --chain $ETH_CHAIN_NAME
  fi

  if [ "$1" = "TENDERMINT_CLIENT" ]; then
    yarn hardhat deployTendermint --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "TSS_CLIENT" ]; then
    yarn hardhat deployTssClient --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "ROUTING_ADDRESS" ]; then
    yarn hardhat deployRouting --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "PACKET_ADDRESS" ]; then
    yarn hardhat deployPacket --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "TRANSFER_ADDRESS" ]; then
    yarn hardhat deployTransfer --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "FT" ]; then
    yarn hardhat addRouting --module FT --address $TRANSFER_ADDRESS --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "RCC_ADDRESS" ]; then
    yarn hardhat deployRcc --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "CONTRACT" ]; then
    yarn hardhat addRouting --module CONTRACT --address $RCC_ADDRESS --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "MULTICALl_ADDRESS" ]; then
    yarn hardhat deployMultiCall --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "grantRole" ]; then
    yarn hardhat grantRole --role $MULTISEND_ROLE --to $MULTICALl_ADDRESS --network $ETH_NETWORK_NAME
  fi


  if [ "$1" = "PROXY_ADDRESS" ]; then
    yarn hardhat deployProxy --network $ETH_NETWORK_NAME
  fi

  if [ "$1" = "hasRole" ]; then
    yarn hardhat hasRole --role $MULTISEND_ROLE --to $MULTICALl_ADDRESS --network $ETH_NETWORK_NAME
  fi

}

function tool_check() {
  temp=0
  while true; do
    temp=`expr $temp + 1`

    # loop 5 times, or break
    if [ "$temp" = "5" ]; then
      exit 0
    fi

    # deploy
    hardhat_deploy_base $1
    grep $1 env.txt
    if [ "$?" = "0" ]; then
      break
    fi

  done

  echo "deploy $1 success!"
  source env.txt
}

function deploy_base_on_eth() {
    cd ../helper/xibc-contracts/evm

    tool_check LIGHT_CLIENT_GEN_VALHASH_ADDRESS
    tool_check ACCESS_MANAGER_ADDRESS
    tool_check CLIENT_MANAGER_ADDRESS
    tool_check TENDERMINT_CLIENT

    tool_check TSS_CLIENT

    tool_check ROUTING_ADDRESS
    tool_check PACKET_ADDRESS
    tool_check TRANSFER_ADDRESS
    tool_check FT addRouting
    tool_check RCC_ADDRESS
    tool_check CONTRACT addRouting
    tool_check MULTICALl_ADDRESS
    tool_check grantRole
    tool_check PROXY_ADDRESS
    tool_check hasRole
}

update_env

deploy_base_on_eth

rm -rf ../../../eth-tele/env.txt
mv env.txt ../../../eth-tele/env_var

# exit to pre path
cd  ../../../eth-tele