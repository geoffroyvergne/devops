# Container Pgpool from debian

FROM gvergne/debian:latest

RUN apt-get update -y && apt-get install -y postgresql-client postgresql-contrib pgpool2 net-tools arping

RUN chmod u+s /sbin/ifconfig
RUN chmod u+s /sbin/ip
RUN chmod u+s /usr/sbin/arping

COPY conf/pgpool.conf /etc/pgpool2/pgpool.conf
COPY conf/pcp.conf /etc/pgpool2/pcp.conf
COPY conf/pool_hba.conf /etc/pgpool2/pool_hba.conf

COPY conf/pool_password /etc/pgpool2/pool_password
RUN chmod 0600 /etc/pgpool2/pool_password

COPY /conf/pg_pass_file /etc/postgresql/9.4/main/pg_pass_file
RUN chmod 0600 /etc/postgresql/9.4/main/pg_pass_file
ENV PGPASSFILE /etc/postgresql/9.4/main/pg_pass_file

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh", \
"pgpool", \
"--dont-detach", \
"--clear", "--discard-status", "--clear-oidmaps", \
"--config-file", "/etc/pgpool2/pgpool.conf", \
"--hba-file", "/etc/pgpool2/pool_hba.conf", \
"--pcp-file", "/etc/pgpool2/pcp.conf", \
"--debug"]
