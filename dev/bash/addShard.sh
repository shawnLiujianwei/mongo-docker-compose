#!/usr/bin/env bash
docker exec -it mongos_1 bash -c "echo \"sh.addShard('shard_1_replSet/shard_1_replSet:27017'); sh.addShard('mongors2/shard_2_replSet:27017');\" | mongo "