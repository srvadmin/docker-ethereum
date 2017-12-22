#!/bin/bash
set -e

if [ $# -eq 0 ]; then
  exec geth --cache=4096 --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "web3,personal,admin,debug,db,net,eth,miner,rpc,txpool" "$@"
else
  exec "$@"
fi
