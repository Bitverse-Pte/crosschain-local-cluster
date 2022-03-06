#!/bin/bash

cd ../helper/xibc-contracts/evm

## bond tokens
yarn hardhat bindToken --transfer $TRANSFER_ADDRESS \
--address $ETHTELE --oritoken 0x0000000000000000000000000000000000000000 \
--orichain teleport --network $ETH_NETWORK_NAME

# exit to pre
cd ../../../eth-tele
