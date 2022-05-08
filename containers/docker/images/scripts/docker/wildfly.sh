#!/usr/bin/env bash

if [ "$(docker ps -a -f status=exited | grep wildfly-container)" ];
then
    echo "start wildfly container"
    docker start wildfly-container
fi

if [ "$(docker ps -a | grep wildfly-container)" ];
then
    echo "wildfly container already exists"
else
    echo "create wildfly container"

    docker run -d \
    --name wildfly-container \
    -p 8081:8081 -p 9991:9991 \
    --link postgresql-container \
    -v /Users/gv/dev/workspace-jee/jee-base/jee-base-ear/target/jee-base-ear.ear:/tmp/jee-base-ear.ear \
    wildfly -Djboss.socket.binding.port-offset=1
fi

docker ps | grep jetty-container
