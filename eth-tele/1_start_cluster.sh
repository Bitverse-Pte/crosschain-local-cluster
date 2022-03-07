#!/bin/bash

docker rm tele0 eth0


# start eth private chain nodes
function startEth() {
  cd cluster-config/1_eth_nodes
  sudo rm -r ~/chaindata/
  sudo cp -r ethtest/data ~/chaindata
  docker run -d --name eth0   --net host  -v ~/chaindata:/root/chaindata -v /usr/bin/geth:/usr/bin/geth \
            ubuntu:20.04 geth --networkid 3133789  --mine --miner.threads 1 \
              --datadir /root/chaindata --nodiscover --http --http.addr "0.0.0.0" --http.port 9545 \
              --http.api eth,txpool,personal,net,debug,web3  --rpc.allow-unprotected-txs --http.vhosts=*
}

# start tele node
function startTele() {
  cd ../1_tele_nodes
  sudo rm -rf ~/teleport_testnet
  sudo cp -r teleport_testnet ~/
  docker run -itd  --net host   --name=tele0   -v ~/teleport_testnet/validators/validator0/teleport/:/root/teleport  \
    -v ~/go/bin/teleport:/usr/bin/teleport ubuntu:20.04  \
    teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
}

startEth
startTele

# exit to pre path
cd ../..
