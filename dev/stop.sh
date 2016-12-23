#!/usr/bin/env bash
docker-compose -f servers.yml down
docker-compose -f configs.yml down
docker-compose -f mongos.yml down
