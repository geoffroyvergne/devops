# Zookeeper

* `GitHub`        [(docker/zookeeper)](https://github.com/geoffroyvergne/docker/tree/master/zookeeper)
* `Dockerfile`    [(docker/zookeeper/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/zookeeper/Dockerfile)
* `Docker Hub`    [(gvergne/zookeeper)](https://hub.docker.com/r/gvergne/zookeeper/)

[![](https://images.microbadger.com/badges/image/gvergne/zookeeper.svg)](https://microbadger.com/images/gvergne/zookeeper "Get your own image badge on microbadger.com")

![Zookeeper logo](http://zookeeper.apache.org/images/zookeeper_small.gif)

## About this image
Zookeeper Docker image

## How to use this image

### Build
```
docker build -t zookeeper ./zookeeper
```

### Inspect container
```
docker run -it --entrypoint=bash zookeeper
```

### Environment variables

* `ZOOKEEPER_TICK_TIME` (default 2000)
* `ZOOKEEPER_CLIENT_PORT` (default 2181)
* `ZOOKEEPER_INIT_LIMIT` (default 5)
* `ZOOKEEPER_SYNC_LIMIT` (default 2)
* `ZOOKEEPER_OVERRIDE_CONF` Add more configuration here
               
### Run
```               
docker run -d \
--name zookeeper-container \
-e ZOOKEEPER_OVERRIDE_CONF="$(cat zookeeper/conf/zookeeper_override_conf.cfg)" \
-p 2181:2181 \
zookeeper
```

```
docker run --rm -it \
--name zookeeper-container \
--volume /Users/gv/dev/docker/zookeeper/conf/zookeeper_override_conf.conf:/tmp/override.cfg \
-p 2181:2181 \
zookeeper
```

```
docker run --rm -it \
--name zookeeper-container \
--volume /Users/gv/dev/docker/zookeeper/conf/zoo.cfg:/tmp/zoo.cfg \
-p 2181:2181 \
zookeeper
```
