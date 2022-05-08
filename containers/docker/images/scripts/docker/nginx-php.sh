#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(docker ps -a | grep web-data)" ];
then
	echo "web-data exists"
else
	echo "web-data doesnt exists"
	${SCRIPT_DIR_PATH}/web-data.sh
fi

#if [ "$(docker images | grep nginx)" ];
#then
#	echo "nginx image exists"
#else
#	echo "nginx image doesnt exists"
#	docker rmi $(docker images -q -f dangling=true)
#	docker build -t nginx ${DOCKER_DIR}/nginx
#fi

if [ "$(docker ps -a -f status=exited | grep nginx-php-container)" ];
then
    echo "start nginx-php container"
    docker start nginx-php-container
fi

if [ "$(docker ps -a | grep nginx-php-container)" ];
then
	echo "nginx-php container already exists"
else
	echo "create nginx-php container"

read -d '' OVERRIDE_CONF << EOF
    location ~ \\\.php {
		try_files \$uri \$uri/ =404;
		fastcgi_split_path_info ^(.+\\\.php)(/.+)\$;
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

#echo "$OVERRIDE_CONF"

docker run -d \
--name nginx-php-container \
--link mariadb-container:mariadb-container \
--link php-fpm-container:php-fpm-container \
--volumes-from web-data \
-e NGINX_PORT=82 \
-e NGINX_SERVER_NAME="localhost debianserver debianserver.com" \
-e NGINX_AUTO_INDEX=on \
-e NGINX_INDEX="test.html index.htm index.php" \
-e NGINX_OVERRIDE_CONF="$OVERRIDE_CONF" \
-p 82:82 \
gvergne/nginx:latest
fi

docker ps | grep nginx-php-container
