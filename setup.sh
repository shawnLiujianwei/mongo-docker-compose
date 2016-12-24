#!/usr/bin/env bash
## Setup Docker
NETWORK_NAME=${1:-my-mongo-cluster}
REPLICASET_NAME=${2:-my-mongo-set}

# Remove old network if has.
docker network rm my-mongo-cluster
# Create docker network name.
docker network create $NETWORK_NAME
# List docker network.
docker network ls

## Setup Mongo
# List existing mongo process.
pgrep mongo
# Kill existing process if has.
pkill mongo

# Create mongo container 0.
./setup-container.sh 0 $NETWORK_NAME $REPLICASET_NAME
# Create mongo container 1.
./setup-container.sh 1 $NETWORK_NAME $REPLICASET_NAME
# Create mongo container 2.
./setup-container.sh 2 $NETWORK_NAME $REPLICASET_NAME

# Provide hint.
echo 'Hint for minimum architecture of a replica set has three members.'
echo '-----------------------------------------------------------------'
echo '> rs.initiate({"_id":"my-mongo-set","members":[{"_id":0,"host":"mongo0:27017","priority":1},{"_id":1,"host":"mongo1:27017","priority":0.5},{"_id":2,"host":"mongo2:27017","priority":0.3}]})'
echo '-----------------------------------------------------------------'

# List existing mongo process.
pgrep mongo

# Connect to available host.
docker exec -it mongo0 mongo