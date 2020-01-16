# Debian

* `GitHub`        [(docker/debian)](https://github.com/geoffroyvergne/docker/tree/master/debian)
* `Dockerfile`    [(docker/debian/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/debian/Dockerfile)
* `Docker Hub`    [(gvergne/debian)](https://hub.docker.com/r/gvergne/debian/)

![Docker Pulls](https://img.shields.io/docker/pulls/gvergne/debian.svg) ![Docker Stars](https://img.shields.io/docker/stars/gvergne/debian.svg)

![Debian logo](https://raw.githubusercontent.com/docker-library/docs/b449be7df57e9ed9086bb5821bfb5d6cdc5d67a4/debian/logo.png)

## About this image
This Debian image just extends `debian:jessie` official image with the following added in `/etc/apt/sources.list`

```
deb http://ftp.de.debian.org/debian jessie-backports main
```

## How to use this image

### Build
```
docker build -t debian ./debian
```
               
### Run
```               
docker run -it debian bash
```
