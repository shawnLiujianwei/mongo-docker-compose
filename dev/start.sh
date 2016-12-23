#!/usr/bin/env bash
echo "run mongo instance"
docker-compose -f servers.yml up -d
sleep 3
echo "run config servers and init replicaSet"
docker-compose -f configs.yml up -d
sleep 3
./bash/configReplSet.sh
echo "run mongos servers"
docker-compose -f mongos.yml up -d
sleep 3
./bash/addShard.sh
echo "add shardings "
