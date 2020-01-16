# Container PHP5-FPM from gvergne/debian-server:latest

FROM gvergne/debian-server:latest

RUN apt-get update -y && \ 
	apt-get install -y --no-install-recommends --no-install-suggests \
	php5-fpm \
	php5-mysql \
	php5-mcrypt \
	php5-pgsql \
	php5-sqlite \
	php5-xcache \
	php5-xdebug

COPY conf/php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY conf/php.ini /etc/php5/fpm/php.ini
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

RUN ln -sf /dev/stdout /var/log/php5-fpm.log

RUN touch /var/log/php5-fpm-error.log
RUN ln -sf /dev/stdout /var/log/php5-fpm-error.log

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/docker-entrypoint.sh", "php5-fpm", "--nodaemonize", "--fpm-config", "/etc/php5/fpm/php-fpm.conf"]
#CMD["php5-fpm", "--nodaemonize", "--fpm-config", "/etc/php5/fpm/php-fpm.conf", "$@"]