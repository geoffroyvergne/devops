#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		wildfly-jee-base-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker postgresql-docker
# Should-Stop:    $network docker postgresql-docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Docker Wildfly Jee Base
### END INIT INFO

#update-rc.d wildfly-jee-base-docker remove
#update-rc.d wildfly-jee-base-docker defaults

CONTAINER_NAME="wildfly-jee-base-container"
IMAGE_NAME="gvergne/wildfly:latest"

case "$1" in
    start)

        docker run -d \
            --restart unless-stopped \
            --name wildfly-jee-base-container \
            -p 8081:8081 -p 9991:9991 \
            --link postgresql-container \
            -e WILDFLY_DATASOURCE_CONNECTION_HOST="postgresql-container" \
            -e WILDFLY_DATASOURCE_CONNECTION_PORT="5432" \
            -e WILDFLY_DATASOURCE_CONNECTION_SCHEMA="wildfly" \
            -v /mnt/dev/workspace-jee/jee-base/jee-base-ear/target/jee-base-ear.ear:/tmp/jee-base-ear.ear \
            ${IMAGE_NAME} -Djboss.socket.binding.port-offset=1 \
            -b 0.0.0.0 \
            -bmanagement 0.0.0.0 \
            -Djboss.socket.binding.port-offset=1

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
