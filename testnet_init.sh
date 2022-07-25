#!/bin/bash

KEY="test1"
CHAINID="localnet_9002-1"
MONIKER="localtestnet"
KEYRING="os"
KEYALGO="secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
# TRACE=""
fetchd tendermint unsafe-reset-all
# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

make install
rm -rf .fetchd*



fetchd init --chain-id localnet_9002-1 my-local-node-name --home .fetchd



# Change parameter token denominations to afet
cat .fetchd/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="afet"' > .fetchd/config/tmp_genesis.json && mv .fetchd/config/tmp_genesis.json .fetchd/config/genesis.json
# Change parameter token denominations to afet
cat .fetchd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="afet"' > .fetchd/config/tmp_genesis.json && mv .fetchd/config/tmp_genesis.json .fetchd/config/genesis.json
cat .fetchd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="afet"' > .fetchd/config/tmp_genesis.json && mv .fetchd/config/tmp_genesis.json .fetchd/config/genesis.json
cat .fetchd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="afet"' > .fetchd/config/tmp_genesis.json && mv .fetchd/config/tmp_genesis.json .fetchd/config/genesis.json
cat .fetchd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="afet"' > .fetchd/config/tmp_genesis.json && mv .fetchd/config/tmp_genesis.json .fetchd/config/genesis.json




fetchd add-genesis-account validator 100000000000000000000afet --home .fetchd


fetchd add-genesis-account fetch1320mysnjer5r8vesmf33tlx26syscvek5824h7 100000000000000000000000afet --home .fetchd



fetchd add-genesis-account henry 100000000000000000000000afet --home .fetchd


fetchd add-genesis-account fetch1n7yrkyhaq6f8znp09zlxcsxn4ldepqwn9fh7fq 100000000000000000000000afet --home .fetchd



fetchd gentx validator 100000000000000000000afet --chain-id localnet_9002-1 --home .fetchd


# Collect genesis tx
fetchd collect-gentxs --home .fetchd

