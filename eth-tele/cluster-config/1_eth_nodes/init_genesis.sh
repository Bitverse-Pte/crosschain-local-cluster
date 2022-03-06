rm -rf ethtest

mkdir -p ethtest/data

geth --syncmode=full --nodiscover --datadir ethtest/data init genesis.json

geth --datadir ethtest/data account new

cp genesis.json ethtest/data/geth/chaindata/
