# Container MongoDb from debian-server

FROM gvergne/debian-server:latest

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    openjdk-8-jdk \
    apt-transport-https curl wget

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get -y update && apt-get install -y mongodb-org

#RUN ln -sf /dev/stdout /var/log/mongodb/mongod.log

RUN mkdir -p /etc/mongodb
COPY conf/mongod.yaml /etc/mongodb/mongod.yaml

RUN chown -R mongodb:mongodb /var/lib/mongodb
RUN chown -R mongodb:mongodb /etc/mongodb

#ENTRYPOINT ["mongod", "--config", "/etc/mongod.conf"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh", "mongod", "--config", "/etc/mongodb/mongod.yaml"]
