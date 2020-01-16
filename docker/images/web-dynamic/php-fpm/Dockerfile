FROM php:fpm-alpine

COPY conf/php.ini /usr/local/etc/php/php.ini

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

RUN mkdir -p /usr/share/nginx/html

COPY html/ /usr/share/nginx/html/
