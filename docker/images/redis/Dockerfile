# Container Redis from debian-server

FROM gvergne/debian:latest

#http://download.redis.io/releases/redis-3.2.2.tar.gz

RUN groupadd -r redis && useradd -r -g redis redis

RUN apt-get update -y && \
apt-get install -y build-essential linux-headers-3.16.0-4-amd64 curl ruby ruby-dev rubygems

RUN mkdir -p usr/src/redis

RUN cd $HOME && curl -O http://download.redis.io/releases/redis-3.2.2.tar.gz

RUN cd $HOME && tar zxf $HOME/redis-3.2.2.tar.gz \
    && mv ./redis-3.2.2/* /usr/src/redis \
    && rm $HOME/redis-3.2.2.tar.gz

RUN cp /usr/src/redis/src/redis-trib.rb /usr/local/bin/redis-trib.rb && chmod +x /usr/local/bin/redis-trib.rb
RUN gem install redis

RUN cd /usr/src/redis/src && make && make install
RUN rm -Rf /usr/src/redis

RUN mkdir -p /var/lib/redis && chown redis:redis /var/lib/redis
RUN mkdir -p /var/lib/redis-cluster && chown redis:redis /var/lib/redis-cluster

RUN mkdir -p /etc/redis && chown redis:redis /etc/redis

COPY conf/redis.conf /etc/redis/redis.conf
COPY conf/sentinel.conf /etc/redis/sentinel.conf

RUN echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
#RUN echo never > /sys/kernel/mm/transparent_hugepage/enabled

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh", "redis-server", "/etc/redis/redis.conf"]