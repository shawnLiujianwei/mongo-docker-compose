#!/usr/bin/env bash
#!/bin/bash
CONTAINER_INDEX=$1
CONTAINER_NAME="mongo"$1
mkdir $CONTAINER_NAME
DB_PORT=$((30000+$CONTAINER_INDEX))
HTTP_PORT=$((28017+$CONTAINER_INDEX))
NETWORK_NAME=$2
REPLICASET_NAME=$3
# Set oplog size.
oplogSizeMB=128

# Remove old container if has.
docker rm $CONTAINER_NAME -f
# Remove old folder if has.
rm -rf $CONTAINER_NAME
# Create log folder.
mkdir -p $CONTAINER_NAME/var/log/mongodb

# Export config.
cat <<EOF > $CONTAINER_NAME/mongo.conf
systemLog:
   destination: file
   path: "/var/log/mongodb/mongod.log"
   logAppend: true
storage:
   dbPath: "$CONTAINER_NAME"
   journal:
      enabled: true
   mmapv1:
      smallFiles: true
net:
   http:
      enabled: true
      JSONPEnabled: true
      RESTInterfaceEnabled: true
setParameter:
   enableLocalhostAuthBypass: true
replication:
   oplogSizeMB: $oplogSizeMB
   replSetName: $REPLICASET_NAME
EOF

docker run -d \
-p $DB_PORT:27017 \
-p $HTTP_PORT:28017 \
--name $CONTAINER_NAME \
--net $NETWORK_NAME \
-v $PWD/$CONTAINER_NAME/var/log/mongodb:/var/log/mongodb \
-v $PWD/$CONTAINER_NAME:/$CONTAINER_NAME \
mongo mongod --config /$CONTAINER_NAME/mongo.conf