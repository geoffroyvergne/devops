FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d

RUN rm /usr/share/nginx/html/*

COPY html/ /usr/share/nginx/html/
