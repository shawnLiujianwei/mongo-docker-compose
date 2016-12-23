#!/usr/bin/env bash
docker-compose -f servers.yml up -d
sleep 2
echo "run mongo instance"
docker-compose -f configs.yml up -d
echo "run config servers"
sleep 10
./bash/configReplSet.sh
echo "collect instance and setup replicaSet"
docker-compose -f mongos.yml up -d
echo "run mongos servers"
sleep 10
./bash/addShard.sh
echo "add shardings "
