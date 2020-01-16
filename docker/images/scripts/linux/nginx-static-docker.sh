#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		nginx-static-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker
# Should-Stop:    $network docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Nginx static
### END INIT INFO

#update-rc.d nginx-static-docker remove
#update-rc.d nginx-static-docker defaults

CONTAINER_NAME="nginx-static-container"
IMAGE_NAME="gvergne/nginx:latest"

case "$1" in
    start)
        docker run -d \
            --restart unless-stopped \
            --name ${CONTAINER_NAME} \
            -v /mnt/www:/var/www/html \
            -e NGINX_PORT=81 \
            -e NGINX_AUTO_INDEX=on \
            -e NGINX_SERVER_NAME="localhost debian-server debian-server.com" \
            -p 81:81 \
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