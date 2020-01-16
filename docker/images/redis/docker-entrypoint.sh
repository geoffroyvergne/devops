#!/bin/bash

LISTEN_ADDRESS=${REDIS_LISTEN_ADDRESS:-"0.0.0.0"}

SENTINEL_MASTER_IP=${REDIS_SENTINEL_MASTER_IP:-""}
SENTINEL_MASTER_PORT=${REDIS_SENTINEL_MASTER_PORT:-"7000"}
SENTINEL_QUORUM=${REDIS_SENTINEL_QUORUM:-"2"}

sed -i -e "s/^bind 127.0.0.1/bind ${LISTEN_ADDRESS}/" -i /etc/redis/redis.conf

#sentinel
#sentinel monitor master 10.0.0.1 6379 2

echo "sentinel monitor master ${SENTINEL_MASTER_IP} ${SENTINEL_MASTER_PORT} ${SENTINEL_QUORUM}" >> /etc/redis/sentinel.conf

exec "$@"
