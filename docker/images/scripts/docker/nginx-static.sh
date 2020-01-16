#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(docker ps -a | grep web-data)" ];
then
    echo "web-data exists"
else
    echo "web-data doesnt exists"
    ${SCRIPT_DIR_PATH}/web-data.sh
fi

#if [ "$(docker images | grep nginx)" ];
#then
#    echo "nginx image exists"
#else
#echo "nginx image doesnt exists"
#    docker rmi $(docker images -q -f dangling=true)
#    docker build -t nginx ${DOCKER_DIR}/nginx
#fi

if [ "$(docker ps -a -f status=exited | grep nginx-static-container)" ];
then
    echo "start nginx-static container"
    docker start nginx-static-container
fi

if [ "$(docker ps -a | grep nginx-static-container)" ];
then
    echo "nginx-static already exists"
else
    echo "create nginx-static container"

    docker run -d \
    --name nginx-static-container \
    --volumes-from web-data \
    -e NGINX_PORT=81 \
    -e NGINX_AUTO_INDEX=on \
    -e NGINX_SERVER_NAME="localhost debian-server debian-server.com" \
    -p 81:81 \
    gvergne/nginx:latest
fi

docker ps | grep nginx-static-container
