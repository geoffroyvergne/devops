#!/bin/bash

BIND_IP=${MONGODB_BIND_IP:-"$(hostname --ip-address)"}
CHANGE_CONFIG=${POSTGRESQL_CHANGE_CONFIG:-"true"}

if [ "$CHANGE_CONFIG" == "true" ];
then
    sed -i -e "s/^bindIp:.*$/bindIp: \"${BIND_IP}\"/" -i /etc/mongodb/mongod.yaml
fi

exec "$@"