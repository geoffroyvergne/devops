# Container MARIADB-GALERA from debian-server

FROM gvergne/debian-server:latest

ENV	DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN add-apt-repository 'deb [arch=amd64,i386] http://de-rien.fr/mariadb/repo/10.1/debian jessie main'

RUN apt-get update -y && apt-get install -y rsync galera-3 mariadb-server

RUN ln -sf /dev/stdout /var/log/mysql.err
RUN ln -sf /dev/stdout /var/log/mysql.log
RUN ln -sf /dev/stdout /var/log/mysql/error.log

RUN chown -R mysql:mysql /var/lib/mysql

COPY conf/galera.cnf /etc/mysql/conf.d/galera.cnf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh", "mysqld", "--init-file=/tmp/init.sql"]

#CMD ["mysqld", "--init-file=/tmp/init.sql"]