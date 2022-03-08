#!/bin/bash

source env_var/variable.sh

cd ../helper/xibc-contracts-local/evm

yarn hardhat transferBase  --transfer 0x0000000000000000000000000000000010000003 \
--receiver $SUPER_ADMIN --destchain $ETH_CHAIN_NAME --relaychain "" --amount 20 --network $TELE_NETWORK_NAME

cd ../../../eth-tele