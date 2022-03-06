#!/bin/bash

function change_relayer_config() {
    #!/bin/bash
    cd relayer_template

    rm -rf config-eth.toml
    cp config-eth-template.toml config-eth.toml

  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/chain_id = 4/chain_id = 3133789/g' ./config-eth.toml
      sed -i '' 's/grpc_addr = "10.41.20.10:9090"/grpc_addr = "localhost:9090"/g' ./config-eth.toml
      sed -i '' 's/start_height = 10138845/start_height = 90/g' ./config-eth.toml
      sed -i '' 's/start_height = 7070/start_height = 50/g' ./config-eth.toml
      sed -i '' 's/chain_name = "rinkeby"/chain_name = "ethmock"/g' ./config-eth.toml
      sed -i '' 's/Opt_priv_key = "2C47DAD44BE377EF09C50CCFB5C1EC9389D337CA7F68F056D0629A8EA622F142"/Opt_priv_key = "6395a7c842a08515961888d21d72f409b61fbce96af1e520384e375f301a8297"/g' ./config-eth.toml
      a='"'${PACKET_ADDRESS}'"'
      b='"'${CLIENT_MANAGER_ADDRESS}'"'
      sed -i '' 's/Addr = "0xba8174c2163bbd2cb08407c954dd14a1b7c1f0c5"/Addr = '$a'/g' ./config-eth.toml
      sed -i '' 's/Addr = "0xe6941a40723dd08bf4ce55c64c837a58ae62a623"/Addr = '$b'/g' ./config-eth.toml
    else
      sed -i  's/chain_id = 4/chain_id = 3133789/g' ./config-eth.toml
      sed -i  's/grpc_addr = "10.41.20.10:9090"/grpc_addr = "localhost:9090"/g' ./config-eth.toml
      sed -i  's/start_height = 10138845/start_height = 90/g' ./config-eth.toml
      sed -i  's/start_height = 7070/start_height = 50/g' ./config-eth.toml
      sed -i  's/chain_name = "rinkeby"/chain_name = "ethmock"/g' ./config-eth.toml
      sed -i  's/Opt_priv_key = "2C47DAD44BE377EF09C50CCFB5C1EC9389D337CA7F68F056D0629A8EA622F142"/Opt_priv_key = "6395a7c842a08515961888d21d72f409b61fbce96af1e520384e375f301a8297"/g' ./config-eth.toml
      a='"'${PACKET_ADDRESS}'"'
      b='"'${CLIENT_MANAGER_ADDRESS}'"'
      sed -i  's/Addr = "0xba8174c2163bbd2cb08407c954dd14a1b7c1f0c5"/Addr = '$a'/g' ./config-eth.toml
      sed -i  's/Addr = "0xe6941a40723dd08bf4ce55c64c837a58ae62a623"/Addr = '$b'/g' ./config-eth.toml
  fi
}

function start_relayer() {
  cd ..
  docker run -itd  --net host  --name=relayer0 -v relayer_template:/root/relayer_template \
      -v ~/go/bin/relayer:/usr/bin/relayer ubuntu:20.04  \
      relayer start -c /root/relayer_template/config-eth.toml
}

change_relayer_config
start_relayer