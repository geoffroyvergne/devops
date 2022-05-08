#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		mariadb-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker
# Should-Stop:    $network docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Docker Mariadb
### END INIT INFO

#update-rc.d mariadb-docker remove
#update-rc.d mariadb-docker defaults

CONTAINER_NAME="mariadb-container"
IMAGE_NAME="gvergne/mariadb:latest"

case "$1" in
    start)
        docker run -d \
            --restart unless-stopped \
            -e MYSQL_ROOT_PASSWORD=root \
            -v /data/db/mariadb:/var/lib/mysql \
            --name ${CONTAINER_NAME} \
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