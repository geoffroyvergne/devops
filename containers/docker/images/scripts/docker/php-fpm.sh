#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"

if [ "$(docker ps -a | grep web-data)" ];
then
    echo "web-data exists"
else
    echo "web-data doesnt exists"
    docker create -v /mnt/www:/var/www/html --name web-data gvergne/debian-server:latest /bin/true
fi

#if [ "$(docker images | grep php-fpm)" ];
#then
#    echo "php-fpm image exists"
#else
#    echo "php-fpm image doesnt exists"
#    docker rmi $(docker images -q -f dangling=true)
#    docker build -t php-fpm ${DOCKER_DIR}/php
#fi

if [ "$(docker ps -a -f status=exited | grep php-fpm-container)" ];
then
    echo "start php-fpm container"
    docker start php-fpm-container
fi

if [ "$(docker ps -a | grep php-fpm-container)" ];
then
    echo "php-fpm already exists"
else
    echo "create php-fpm container"

    docker run -d \
    --name php-fpm-container \
    --volumes-from web-data \
    --link mariadb-container:mariadb-container \
    -e PHP_BIND_HOST=0.0.0.0:9000 \
    -e PHP_ENABLE_ASP_TAGS=false \
    -e PHP_ENABLE_OPEN_TAGS=false \
    -e PHP_ENV=dev \
    -p 9000:9000 \
    gvergne/php-fpm:latest
fi

docker ps | grep php-fpm-container
