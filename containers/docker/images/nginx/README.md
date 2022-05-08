# Nginx

* `GitHub`        [(docker/nginx)](https://github.com/geoffroyvergne/docker/tree/master/nginx)
* `Dockerfile`    [(docker/nginx/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/nginx/Dockerfile)
* `Docker Hub`    [(gvergne/nginx)](https://hub.docker.com/r/gvergne/nginx/)

![Docker Pulls](https://img.shields.io/docker/pulls/gvergne/nginx.svg) ![Docker Stars](https://img.shields.io/docker/stars/gvergne/nginx.svg)

![Nginx logo](https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/nginx/logo.png)

## About this image
Yet another Nginx image ...
This image do not use SSL because I use HaProxy as SSL frontend.

## How to use this image

### Environment variables

* `NGINX_PORT` Port NGINX bind (default 80)
* `NGINX_SERVER_NAME` (default localhost) 
* `NGINX_AUTO_INDEX` Index directory without index.* file (default off)
* `NGINX_INDEX` Index file (default index.html index.htm)
* `NGINX_OVERRIDE_CONF` Add more configuration here (see examples bellow)

### Build

`docker build -t nginx ./nginx`

### Run

`docker run -it --entrypoint=bash nginx`

### Client

#### Run curl directly from running container
`docker exec -it nginx-container curl -Isk localhost:81`

#### Run curl from a new dedicated container
`docker run --rm -it --entrypoint=bash nginx -c "curl -Isk 192.168.99.100:81"`

#### Run local curl
`curl -Isk 192.168.99.100:81`

#### Static

```
docker run -d \
--name nginx-container \
-v /Users/gv/www:/var/www/html \
-e NGINX_PORT=81 \
-e NGINX_AUTO_INDEX=on \
-e NGINX_SERVER_NAME="localhost debian-server debian-server.com debian-server-docker.com" \
-p 81:81 \
nginx
```

#### PHP

```
docker run -d \
--name nginx-php-container \
--link mariadb-container:mariadb-container \
--link php-fpm-container:php-fpm-container \
-v /Users/gv/www:/var/www/html \
-e NGINX_PORT=82 \
-e NGINX_SERVER_NAME="localhost debianserver debianserver.com" \
-e NGINX_AUTO_INDEX=on \
-e NGINX_INDEX="index.html index.htm index.php" \
-e NGINX_OVERRIDE_CONF="$(cat nginx/conf/override_default_php.conf)" \
-p 82:82 \
nginx
```

#### Custom config

```
docker run --rm -it \
--name nginx-php-container \
--link mariadb-container:mariadb-container \
--link php-fpm-container:php-fpm-container \
--volumes-from web-data \
--volume /Users/gv/dev/docker/nginx/conf/default-php.conf:/etc/nginx/sites/default.conf \
-p 82:82 \
nginx
```
