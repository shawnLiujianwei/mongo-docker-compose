#!/usr/bin/env bash
docker-compose -f servers.yml up -d
sleep 3
echo "run mongo instance"
docker-compose -f configs.yml up -d
echo "run config servers"
sleep 3
./bash/configReplSet.sh
echo "collect instance and setup replicaSet"
docker-compose -f mongos.yml up -d
echo "run mongos servers"
sleep 3
./bash/addShard.sh
echo "add shardings "
