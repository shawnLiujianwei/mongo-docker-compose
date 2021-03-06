#!/usr/bin/env bash
for (( rs = 1; rs < 3; rs++ )); do
  echo "Intializing replica ${rs} set"
  replicate="rs.initiate(); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"shard_${rs}_replSet_1\"; rs.reconfig(cfg); rs.add(\"shard_${rs}_replSet_2\");"
  docker exec -it shard_${rs}_replSet_1 bash -c "echo '${replicate}' | mongo"
done