#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"

JETTY_HTTP_HOST=${1:-"0.0.0.0"}
JETTY_HTTP_PORT=${2:-"8181"}
JETTY_WAR_PATH=${3:-"/mnt/dev/workspace-jee/maven-projects/default/target"}
JETTY_WAR_NAME=${4:-"default.war"}

#if [ "$(docker images | grep jetty)" ];
#then
#echo "jetty image exists"
#else
#echo "jetty image doesnt exists"
#docker rmi $(docker images -q -f dangling=true)
#docker build -t jetty ${DOCKER_DIR}/jetty
#fi

if [ "$(docker ps -a -f status=exited | grep jetty-container)" ];
then
    echo "start jetty container"
    docker start jetty-container
fi

if [ "$(docker ps -a | grep jetty-container)" ];
then
    echo "jetty container already exists"
else
    echo "create jetty container"

    docker run -d \
    --name jetty-container \
    -v ${JETTY_WAR_PATH}/${JETTY_WAR_NAME}:/opt/jetty/webapps/${JETTY_WAR_NAME}:ro \
    -p ${JETTY_HTTP_PORT}:${JETTY_HTTP_PORT} \
    gvergne/jetty:latest \
    -Djetty.http.host=${JETTY_HTTP_HOST} \
    -Djetty.http.port=${JETTY_HTTP_PORT}
fi

docker ps | grep jetty-container
