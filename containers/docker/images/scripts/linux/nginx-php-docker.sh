#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		nginx-php-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker mariadb-docker php-fpm-docker
# Should-Stop:    $network docker mariadb-docker php-fpm-docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Nginx php
### END INIT INFO

#update-rc.d nginx-php-docker remove
#update-rc.d nginx-php-docker defaults

CONTAINER_NAME="nginx-php-container"
IMAGE_NAME="gvergne/nginx:latest"

OVERRIDE_CONF=$(cat <<EOF
    location ~ \\.php {
		try_files \$uri \$uri/ =404;
		fastcgi_split_path_info ^(.+\\.php)(/.+)\$;
		fastcgi_pass php-fpm-container:9000;
		fastcgi_index index.php;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

		fastcgi_param HTTPS \$http_x_custom_enable_https;

		fastcgi_param REMOTE_ADDR \$http_x_custom_host;
		fastcgi_param SERVER_ADDR \$http_x_custom_host;
		fastcgi_param REMOTE_PORT \$http_x_custom_port;
		fastcgi_param SERVER_PORT \$http_x_custom_port;
	}

	location ~ ^/(status|ping)$ {
		access_log off;
		allow 192.168.56.22;
		deny all;
		include fastcgi_params;
		fastcgi_pass localhost:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	}
}
EOF
)

case "$1" in
    start)
    docker run -d \
        --restart unless-stopped \
        --name ${CONTAINER_NAME} \
        --link mariadb-container:mariadb-container \
        --link php-fpm-container:php-fpm-container \
        -v /mnt/www:/var/www/html \
        -e NGINX_PORT=82 \
        -e NGINX_SERVER_NAME="localhost debianserver debianserver.com" \
        -e NGINX_AUTO_INDEX=on \
        -e NGINX_INDEX="test.html index.htm index.php" \
        -e NGINX_OVERRIDE_CONF="$OVERRIDE_CONF" \
        -p 82:82 \
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