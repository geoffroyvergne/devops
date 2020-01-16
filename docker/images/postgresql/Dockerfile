# Container Postgresql from debian-server

FROM gvergne/debian:latest

RUN apt-get update -y && apt-get install -y curl \
postgresql postgresql-client postgresql-contrib \
postgresql-9.4-pgpool2 repmgr postgresql-9.4-repmgr

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
 && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
 && gpg --verify /usr/local/bin/gosu.asc \
 && rm /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu

RUN mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp
RUN chown postgres.postgres /var/run/postgresql/9.4-main.pg_stat_tmp -R

#RUN mkdir /var/lib/postgresql/data
#RUN chown -R postgres:postgres /var/lib/postgresql/data

RUN chown -R postgres:postgres /var/lib/postgresql/9.4/main

COPY sql/ /tmp/sql

COPY /conf/pg_pass_file /etc/postgresql/9.4/main/pg_pass_file
RUN chmod 0600 /etc/postgresql/9.4/main/pg_pass_file
ENV PGPASSFILE /etc/postgresql/9.4/main/pg_pass_file

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh", "gosu", "postgres", "/usr/lib/postgresql/9.4/bin/postgres", "--config-file=/etc/postgresql/9.4/main/postgresql.conf"]

#CMD ["gosu", "postgres", "/usr/lib/postgresql/9.4/bin/postgres", "--config-file=/etc/postgresql/9.4/main/postgresql.conf", "$@"]

