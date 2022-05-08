#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VOLUME_FROM="mariadb-data"
ROOT_PASSWORD="root"

if [ "$(docker ps -a | grep mariadb-data)" ];
then
    echo "mariadb-data exists"
else
    echo "mariadb-data doesnt exists"
    ${SCRIPT_DIR_PATH}/data.sh mariadb
fi

#if [ "$(docker images | grep mariadb)" ];
#then
#    echo "mariadb image exists"
#else
#    echo "mariadb image doesnt exists"
#    docker rmi $(docker images -q -f dangling=true)
#    docker build -t mariadb ${DOCKER_DIR}/mariadb
#fi

if [ "$(docker ps -a -f status=exited | grep mariadb-container)" ];
then
    echo "start mariadb container"
    docker start mariadb-container
fi

if [ "$(docker ps -a | grep mariadb-container)" ];
then
    echo "mariadb container already exists"
else
    echo "create mariadb container"

    docker run -d \
    -e MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD} \
    --volumes-from ${VOLUME_FROM} \
    --name mariadb-container \
    gvergne/mariadb:latest
fi

docker ps | grep mariadb-container
