FROM nginx:alpine

COPY default.tmpl /etc/nginx/default.tmpl

ENV NGINX_BACKEND_API_TEST="http://192.168.1.21:8181/api/test/" \
NGINX_PORT=80 \
NGINX_SERVER_NAME=localhost \
NGINX_AUTO_INDENT=on


CMD /bin/sh -c "envsubst < /etc/nginx/default.tmpl > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;' || cat /etc/nginx/conf.d/default.conf"
