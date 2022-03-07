#!/bin/bash

function startTssNode(){
  rm -rf ~/tssconfig
  cp -r tss_config ~/tssconfig

  docker rm -f tssnode0 tssnode1 tssnode2 tssnode3 tssbridge tssrelayd

  #bridge need database
  #we need a database to save data.
  docker run -itd --net host --name mysql-bridge -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=tss mysql

  #wait database start
  sleep 10

#  docker run -itd  --net host  --name=tssnode0  -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/tssnode:/usr/bin/tssnode   ubuntu:20.04  tssnode start -c /root/tssconfig/node0_config.toml -p 8080

#  docker run -itd  --net host  --name=tssnode1  -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/tssnode:/usr/bin/tssnode ubuntu:20.04  tssnode start -c /root/tssconfig/node1_config.toml -p 8081

#  docker run -itd  --net host  --name=tssnode2  -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/tssnode:/usr/bin/tssnode  ubuntu:20.04  tssnode start -c /root/tssconfig/node2_config.toml -p 8082

#  docker run -itd  --net host  --name=tssnode3  -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/tssnode:/usr/bin/tssnode  ubuntu:20.04  tssnode start -c /root/tssconfig/node3_config.toml -p 8083

#  docker run -itd --net host --name=tssbridge -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/bridge-api:/usr/bin/bridge-api ubuntu:20.04 bridge-api --config /root/tssconfig/bridge_api_config.toml

#  docker run -itd --net host --name=tssrelayd -v ~/tssconfig/:/root/tssconfig -v ~/go/bin/relayd:/usr/bin/relayd ubuntu:20.04 relayd --config /root/tssconfig/relayd_config.toml
}

startTssNode
