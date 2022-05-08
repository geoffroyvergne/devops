# JETTY

* `GitHub`        [(docker/jetty)](https://github.com/geoffroyvergne/docker/tree/master/jetty)
* `Dockerfile`    [(docker/jetty/Dockerfile)](https://github.com/geoffroyvergne/docker/blob/master/jetty/Dockerfile)
* `Docker Hub`    [(gvergne/jetty)](https://hub.docker.com/r/gvergne/jetty/)

![Docker Pulls](https://img.shields.io/docker/pulls/gvergne/jetty.svg) ![Docker Stars](https://img.shields.io/docker/stars/gvergne/jetty.svg)

![Jetty logo](https://www.eclipse.org/jetty/images/jetty-logo-80x22.png)

## About this image
Yet another Jetty image ...
This image do not use SSL because I use HaProxy as SSL frontend.

## How to use this image

### Build
`docker build -t jetty ./jetty`

### Run
`docker run --rm -it --entrypoint=bash jetty`

### Client

#### Run curl directly from running container
`docker exec -it jetty-container curl -Isk localhost:8181`

#### Run curl from a new dedicated container
`docker run --rm -it --entrypoint=bash jetty -c "curl -Isk 192.168.99.100:8181/default"`

#### Run local curl
`curl -Isk 192.168.99.100:8181/default`

#### Deploy app

```
docker run -d \
--name jetty-container \
-v /Users/gv/dev/workspace-jee/maven-projects/default/target/default.war:/opt/jetty/webapps/default.war:ro \
-p 8181:8181 \
jetty \
-Djetty.http.host=0.0.0.0 \
-Djetty.http.port=8181
```