#!/bin/bash

CONTAINER=$1
PORT=$2
IP_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.Networks.postgresql.IPAddress }}' ${CONTAINER})

echo "IP_ADDRESS ${IP_ADDRESS}"
docker exec pgpool-container bash \
-c "psql -h ${IP_ADDRESS} -p ${PORT}  -U postgres -c 'show pool_nodes;'"
