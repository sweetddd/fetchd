#!/bin/bash

rm -rf data/node0
rm -rf data/node1
rm -rf data/node2
rm -rf data/node3
rm -rf data/node4

fetchd init node0 --chain-id testnet_9003-1 --home data/node0
fetchd init node1 --chain-id testnet_9003-1 --home data/node1
fetchd init node2 --chain-id testnet_9003-1 --home data/node2
fetchd init node3 --chain-id testnet_9003-1 --home data/node3
fetchd init node4 --chain-id testnet_9003-1 --home data/node4


#fetchd keys add node1
#fetchd keys add node2
#fetchd keys add node3



cat data/node0/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="afet"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
# Change parameter token denominations to afet
cat data/node0/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="afet"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="afet"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="afet"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="afet"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json


fetchd add-genesis-account fetch18ehzjqle9d8a7qgtjyx8vllv9skwhflul2lmza 10000000000000000000000000000afet --home data/node0
fetchd add-genesis-account fetch1kqn6f3kmu70smsx469fwtsvaqq3t0qerqgjlkt 10000000000000000000000000000afet --home data/node0
fetchd add-genesis-account fetch1320mysnjer5r8vesmf33tlx26syscvek5824h7 100000000000000000000000000afet --home data/node0
fetchd add-genesis-account fetch1n7yrkyhaq6f8znp09zlxcsxn4ldepqwn9fh7fq 100000000000000000000000000afet --home data/node0

fetchd add-genesis-account node1 100000000000000000000afet --home data/node0
fetchd add-genesis-account node2 100000000000000000000afet --home data/node0
fetchd add-genesis-account node3 100000000000000000000afet --home data/node0
fetchd add-genesis-account node4 100000000000000000000afet --home data/node0
fetchd add-genesis-account node6 100000000000000000000afet --home data/node0
fetchd add-genesis-account node2 100000000000000000000afet --home data/node1
fetchd add-genesis-account node3 100000000000000000000afet --home data/node2
fetchd add-genesis-account node4 100000000000000000000afet --home data/node3
fetchd add-genesis-account node6 100000000000000000000afet --home data/node4


fetchd gentx  node1 100000000000000000000afet --home data/node0  --node-id $(fetchd tendermint show-node-id --home data/node0) --chain-id testnet_9003-1
fetchd gentx  node2  100000000000000000000afet --home data/node1  --node-id $(fetchd tendermint show-node-id --home data/node1) --chain-id testnet_9003-1
fetchd gentx  node3 100000000000000000000afet --home data/node2  --node-id $(fetchd tendermint show-node-id --home data/node2) --chain-id testnet_9003-1
fetchd gentx  node4 100000000000000000000afet --home data/node3  --node-id $(fetchd tendermint show-node-id --home data/node3) --chain-id testnet_9003-1
fetchd gentx  node6 100000000000000000000afet --home data/node4  --node-id $(fetchd tendermint show-node-id --home data/node4) --chain-id testnet_9003-1



fetchd collect-gentxs --home data/node0
fetchd collect-gentxs --home data/node1
fetchd collect-gentxs --home data/node2
fetchd collect-gentxs --home data/node3
fetchd collect-gentxs --home data/node4

