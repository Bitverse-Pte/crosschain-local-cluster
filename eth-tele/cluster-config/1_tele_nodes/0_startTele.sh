#!/bin/bash

sudo rm -rf ~/teleport_testnet
sudo cp -r teleport_testnet ~/

docker run -itd  --net host   --name=peer0   \
-v ~/teleport_testnet/validators/validator0/teleport/:/root/teleport  \
-v ~/go/bin/teleport:/usr/bin/teleport ubuntu:20.04  teleport start --home /root/teleport \
--log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
