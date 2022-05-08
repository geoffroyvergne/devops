# Alpine

* `GitHub`        [(docker/alpine)](https://github.com/geoffroyvergne/docker/tree/master/alpine)
* `Dockerfile`    [(docker/alpine/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/alpine/Dockerfile)
* `Docker Hub`    [(gvergne/alpine)](https://hub.docker.com/r/gvergne/alpine/)

![Docker Pulls](https://img.shields.io/docker/pulls/alpine/alpine.svg) ![Docker Stars](https://img.shields.io/docker/stars/gvergne/alpine.svg)

![Alpine logo](https://avatars0.githubusercontent.com/u/7600810?v=3&s=200)

## About this image
This Debian image just extends `alpine:latest` official image with bash and dumb-init

## How to use this image

### Build
```
docker build -t alpine ./alpine
```
               
### Run
```               
docker run -it alpine bash
```
