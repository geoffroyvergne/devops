#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		jetty-default-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker
# Should-Stop:    $network docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Jetty default
### END INIT INFO

#update-rc.d jetty-default-docker remove
#update-rc.d jetty-default-docker defaults

CONTAINER_NAME="jetty-default-container"
IMAGE_NAME="gvergne/jetty:latest"

JETTY_HTTP_HOST="0.0.0.0"
JETTY_HTTP_PORT="8181"
JETTY_WAR_PATH="/mnt/dev/workspace-jee/maven-projects/default/target"
JETTY_WAR_NAME="default.war"

case "$1" in
    start)
        docker run -d \
            --restart unless-stopped \
            --name ${CONTAINER_NAME} \
            -v ${JETTY_WAR_PATH}/${JETTY_WAR_NAME}:/opt/jetty/webapps/${JETTY_WAR_NAME}:ro \
            -p ${JETTY_HTTP_PORT}:${JETTY_HTTP_PORT} \
            ${IMAGE_NAME} \
            -Djetty.http.host=${JETTY_HTTP_HOST} \
            -Djetty.http.port=${JETTY_HTTP_PORT}
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