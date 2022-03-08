#!/bin/bash

function startDB() {
  docker run -itd --net host  --security-opt seccomp=unconfined --name mysql-bridge -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=tss mysql
}

startDB
