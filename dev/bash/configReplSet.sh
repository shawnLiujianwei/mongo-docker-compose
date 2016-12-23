#!/usr/bin/env bash
#for (( rs = 1; rs < 4; rs++ )); do
#  echo "Intializing replica ${rs} set"
#  replicate="rs.initiate(); sleep(1000); cfg = rs.conf();cfg.members[0].host = \"shard_${rs}_replSet_1:27017\";cfg.members[1].host = \"shard_${rs}_replSet_2:27017\"; cfg.members[2].host = \"shard_${rs}_replSet_3:27017\";rs.reconfig(cfg);"
#  docker exec -it shard_${rs}_replSet_1 bash -c "echo '${replicate}' | mongo"
#done

for (( rs = 1; rs < 4; rs++ )); do
  echo "Intializing replica ${rs} set"
  replicate="rs.initiate(); sleep(1000); cfg = rs.conf();cfg.members[0]={\"host\":\"shard_${rs}_replSet_1:27017\",\"_id\":0};cfg.members[1]={\"host\":\"shard_${rs}_replSet_2:27017\",\"_id\":1}; cfg.members[2]={\"host\":\"shard_${rs}_replSet_3:27017\",\"_id\":2};rs.reconfig(cfg);"
  docker exec -it shard_${rs}_replSet_1 bash -c "echo '${replicate}' | mongo"
done

#for (( rs = 1; rs < 4; rs++ )); do
#  echo "Intializing replica ${rs} set"
#  replicate="rs.add({host:\"shard_${rs}_replSet_1:27017\"});sleep(1000);rs.add({host:\"shard_${rs}_replSet_2:27017\"});sleep(1000);rs.add({host:\"shard_${rs}_replSet_3:27017\"});"
#  docker exec -it shard_${rs}_replSet_1 bash -c "echo '${replicate}' | mongo"
#done