# Container Elasticsearch from debian-server

FROM gvergne/debian:latest

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    openjdk-8-jdk \
    apt-transport-https curl wget

RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | tee -a /etc/apt/sources.list

RUN apt-get update && apt-get install kibana

ENTRYPOINT ["/opt/kibana/bin/kibana"]
