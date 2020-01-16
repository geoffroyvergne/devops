# Wildfly

* `GitHub`        [(docker/wildfly)](https://github.com/geoffroyvergne/docker/tree/master/wildfly)
* `Dockerfile`    [(docker/wildfly/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/wildfly/Dockerfile)
* `Docker Hub`    [(gvergne/wildfly)](https://hub.docker.com/r/gvergne/wildfly/)

[![](https://images.microbadger.com/badges/image/gvergne/wildfly.svg)](https://microbadger.com/images/gvergne/wildfly "Get your own image badge on microbadger.com")

![Wildfly logo](http://static.jboss.org/wildfly/images/wildfly-banner-1180px.png)

## About this image
Wildfly Docker image with Postgresql driver and datasource installed and configurable



## How to use this image

### Build
```
docker build -t wildfly ./wildfly
```

### Inspect container
```
docker run -it --entrypoint=bash gvergne/wildfly:latest
```

### Environment variables

* `WILDFLY_ADMIN_USERNAME` (default admin)
* `WILDFLY_ADMIN_GROUP` (default admin)
* `WILDFLY_ADMIN_PASSWORD` (default admin)
* `WILDFLY_DATASOURCE_JNDI_NAME` (default PostgresqlDS)
* `WILDFLY_DATASOURCE_POOL_NAME` (default PostgresqlDS)
* `WILDFLY_DATASOURCE_CONNECTION_HOST` (default postgresql-container)
* `WILDFLY_DATASOURCE_CONNECTION_PORT` (default 5432)
* `WILDFLY_DATASOURCE_CONNECTION_SCHEMA` (default wildfly)
* `WILDFLY_DATASOURCE_USERNAME` (default wildfly)
* `WILDFLY_DATASOURCE_PASSWORD` (default wildfly)

### Run
```               
docker run --rm -it \
--name wildfly-container \
-p 8081:8081 -p 9991:9991 \
--link postgresql-container \
-e WILDFLY_DATASOURCE_CONNECTION_HOST="postgresql-container" \
-e WILDFLY_DATASOURCE_CONNECTION_PORT="5432" \
-e WILDFLY_DATASOURCE_CONNECTION_SCHEMA="wildfly" \
-v /mnt/dev/workspace-jee/jee-base/jee-base-ear/target/jee-base-ear.ear:/tmp/jee-base-ear.ear \
gvergne/wildfly:latest \
-b 0.0.0.0 \
-bmanagement 0.0.0.0 \
-Djboss.socket.binding.port-offset=1
```
