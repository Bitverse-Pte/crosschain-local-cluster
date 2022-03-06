#docker pull augurproject/go-ethereum

sudo rm -r ~/chaindata/
sudo cp -r ethtest/data ~/chaindata

#geth --networkid 3133789  --mine --miner.threads 1 \
#            --datadir ~/chaindata --nodiscover --http --http.addr "0.0.0.0" --http.port 9545 \
#            --http.api eth,txpool,personal,net,debug,web3  --rpc.allow-unprotected-txs --http.vhosts=* --ipcdisable
#

# no resource limit

#docker run -d --name eth0   --net host  -v ~/chaindata:/root/chaindata -v /usr/bin/geth:/usr/bin/geth \
#          ubuntu:20.04 geth --networkid 3133789  --mine --miner.threads 1 \
#            --datadir /root/chaindata --nodiscover --http --http.addr "0.0.0.0" --http.port 9545 \
#            --http.api eth,txpool,personal,net,debug,web3  --rpc.allow-unprotected-txs --http.vhosts=*
#


# resource limit

#docker run -d --name eth0 --cpus=2 -m 1G --memory-swap 3G   \
#           -p 9545:8545 -p 30323:30303  --blkio-weight 100 \
#          webbshi/geth:v1 geth --networkid 3133789  --mine --miner.threads 1 \
#            --datadir /root/chaindata --nodiscover --http --http.addr "0.0.0.0" --http.port 8545 \
#            --http.api eth,txpool,personal,net,debug,web3  --rpc.allow-unprotected-txs --http.vhosts=*
