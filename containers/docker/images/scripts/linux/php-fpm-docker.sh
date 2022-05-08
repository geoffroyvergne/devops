#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		php-fpm-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker mariadb-docker
# Should-Stop:    $network docker mariadb-docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Docker PHP-FPM
### END INIT INFO

#update-rc.d php-fpm-docker remove
#update-rc.d php-fpm-docker defaults

CONTAINER_NAME="php-fpm-container"
IMAGE_NAME="gvergne/php-fpm:latest"

case "$1" in
    start)
    docker run -d \
        --restart unless-stopped \
        --name ${CONTAINER_NAME} \
        -v /mnt/www:/var/www/html \
        --link mariadb-container:mariadb-container \
        -e PHP_BIND_HOST=0.0.0.0:9000 \
        -e PHP_ENABLE_ASP_TAGS=false \
        -e PHP_ENABLE_OPEN_TAGS=false \
        -e PHP_ENV=dev \
        -p 9000:9000 \
        ${IMAGE_NAME}
    exit 0
    ;;

    stop)
        docker rm -f ${CONTAINER_NAME}
    exit 0
	;;

    status)
        docker ps -a | grep ${CONTAINER_NAME}
    exit 0
    ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
    ;;
esac

exit 0