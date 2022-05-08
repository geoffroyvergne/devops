#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		postgresql-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker
# Should-Stop:    $network docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Docker PostgreSQL RDBMS server
### END INIT INFO

#update-rc.d postgresql-docker remove
#update-rc.d postgresql-docker defaults

CONTAINER_NAME="postgresql-container"
IMAGE_NAME="gvergne/postgresql:latest"

case "$1" in
    start)
        docker run -d \
            --restart unless-stopped \
            --name ${CONTAINER_NAME} \
            -p 5432:5432 \
            -v /data/db/postgresql/9.4/main:/var/lib/postgresql/9.4/main \
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
