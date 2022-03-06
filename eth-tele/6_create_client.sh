#!/bin/bash



function  voteProposal(){
  for ((i=0; i<=0; i++))
  do
    teleport tx gov vote $1 yes  \
    --from validator$i --home ~/teleport_testnet/validators/validator$i/teleport \
    --keyring-backend test --keyring-dir  ~/teleport_testnet/validators/validator$i/teleport \
     --chain-id teleport_7001-1  -b block --fees 25000000000000000000atele\
     --node tcp://localhost:26657 -y
  done
}

function voting() {
    # vote proposal-id 1
    voteProposal $1

    sleep $VOTING_PERIOD
    echo "waiting voting-period"
}

function crate_client_on_tele() {
    #!/bin/bash
    rm -rf ~/.teleport-relayer/
    ## generate files
    relayer init
    relayer genFiles eth ethmock $ETH_CHAIN_ID $ETH_CHAIN_URL --packet $PACKET_ADDRESS
    # generate tendemrint client state
    relayer genFiles tendermint teleport teleport_7001-1 localhost:9090 400


    ### client-create
    teleport tx gov submit-proposal client-create \
    ethmock ~/.teleport-relayer/ethmock_clientState.json ~/.teleport-relayer/ethmock_consensusState.json \
    --from validator0 --home ~/teleport_testnet/validators/validator0/teleport \
    --keyring-backend test --keyring-dir ~/teleport_testnet/validators/validator0/teleport \
     --chain-id teleport_7001-1 --deposit 2000000000000000000000atele \
      -y -b block --title "test" --description "test"  \
      --gas auto --fees 25000000000000000000atele --node tcp://localhost:26657

    voting 1

    teleport tx gov submit-proposal relayer-register ethmock \
     teleport1e595uvylhp2av396vnjlk0wrm5y0zwghlrxq7f  \
     --from validator0 --home ~/teleport_testnet/validators/validator0/teleport \
     --keyring-backend test --keyring-dir ~/teleport_testnet/validators/validator0/teleport  \
     --chain-id teleport_7001-1 --deposit  200000000000000000000atele  \
     -y -b block --title "test" --description "test"    \
     --node tcp://localhost:26657 \
     --gas auto  --fees 250000000000000000atele

    voting 2

    ### register-trace  0x1000...3
    teleport tx gov submit-proposal \
    register-trace $ETHTELE 0x0000000000000000000000000000000000000000 ethmock  \
      --from validator0 --home ~/teleport_testnet/validators/validator0/teleport \
     --keyring-backend test --keyring-dir ~/teleport_testnet/validators/validator0/teleport \
     --chain-id teleport_7001-1  --deposit  2000000000000000000000atele \
      -y -b block --title "test" --description "test"   \
       --node tcp://localhost:26657 --gas auto  --fees 2500000000000000000atele

    ### vote for this proposal
    voting 3
}

function create_client_on_eth(){
  cd ../helper/xibc-contracts/evm
  yarn hardhat createClientFromFile  --chain teleport --client $TENDERMINT_CLIENT \
    --clientstate  ~/.teleport-relayer/tendermint_clientState.txt \
    --consensusstate ~/.teleport-relayer/tendermint_consensusState.txt \
    --network $ETH_NETWORK_NAME

  yarn hardhat registerRelayer  --chain teleport  --relayer  $SUPER_ADMIN  \
   --network $ETH_NETWORK_NAME
}

crate_client_on_tele
create_client_on_eth

# exit to pre path
cd ../../../eth-tele