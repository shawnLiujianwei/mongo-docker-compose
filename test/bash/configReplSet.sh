#!/usr/bin/env bash
# rs 是 单台物理机分片的个数, 如 server1_shard1, server1_shard2, 是分两片
for (( rs = 1; rs < 3; rs++ )); do
  echo "Intializing replica ${rs} set"
  replicate="rs.initiate(); sleep(1000); cfg = rs.conf(); cfg.members[0]={host:\"server1_shard${rs}\",_id:0,priority:100};cfg.members[1]={host:\"server2_shard${rs}\",_id:1}; cfg.members[2]={host:\"server3_shard${rs}\",_id:2,arbiterOnly:true};rs.reconfig(cfg);"
  docker exec -it server1_shard${rs} bash -c "echo '${replicate}' | mongo"
done