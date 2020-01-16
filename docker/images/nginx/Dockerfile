# Container NGINX from gvergne/alpine

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN apk add --update curl nginx && rm -rf /var/cache/apk/*

RUN mkdir /run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /tmp/default-base.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /var/www/html
RUN echo "<h1>NGINX</h1>" > /var/www/html/index.html

RUN chown -R nginx:nginx /var/www/html
RUN chmod -R 755 /var/www/html

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
