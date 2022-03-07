#!/bin/bash

function hardhat_deploy_token(){
  if [ "$1" = "ETHUSDT" ]; then
    yarn hardhat deployToken --name ETHUSDT --symbol USDT --decimals 18 --transfer $SUPER_ADMIN --network $ETH_NETWORK_NAME
  fi


  if [ "$1" = "ETHTELE" ]; then
    yarn hardhat deployToken --name ETHTELE --symbol TELE --decimals 18 --transfer $SUPER_ADMIN --network $ETH_NETWORK_NAME
  fi


  if [ "$1" = "TELEUSDT" ]; then
    yarn hardhat deployToken --name TELEUSDT --symbol USDT --decimals 18 --transfer $SUPER_ADMIN --network $TELE_NETWORK_NAME
  fi

  if [ "$1" = "TELEETH" ]; then
    yarn hardhat deployToken --name TELEETH --symbol ETH --decimals 18 --transfer $SUPER_ADMIN --network $TELE_NETWORK_NAME
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
    hardhat_deploy_token $1
    grep $1 env.txt
    if [ "$?" = "0" ]; then
      break
    fi

  done

  echo "deploy $1 success!"
  source env.txt
}


function deploy_token_on_eth() {
    cd ../helper/xibc-contracts/erc20

    tool_check ETHUSDT

    tool_check ETHTELE
}

function deploy_token_on_tele(){
    tool_check TELEUSDT

    tool_check TELEETH
}

deploy_token_on_eth
deploy_token_on_tele

rm -rf ../../../eth-tele/env_var/env_token.txt
mv env.txt ../../../eth-tele/env_var/env_token.txt

cd ../../../eth-tele
source env_var/env_token.txt