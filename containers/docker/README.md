# Docker images

![Docker logo](https://github.com/docker/docker/raw/master/docs/static_files/docker-logo-compressed.png)

## Usefull commands

`docker system prune -a`

### docker environment

`eval "$(docker-machine env default)"`

### docker images

```
docker run docker/whalesay cowsay boo-boo
docker build -t docker-whale .
docker tag 7aa441ffae57 gvergne/docker-whale:latest
docker push gvergne/docker-whale
```

```docker run gvergne/docker-whale cowsay boo-boo```


### Kill all running containers

`docker kill $(docker ps -q)`

### Delete all stopped containers (including data-only containers)

```
docker rm $(docker ps -a -q)
docker rm $(docker ps -q -f status=exited)
```

### Delete all 'untagged/dangling' (<none>) images

```docker rmi $(docker images -q -f dangling=true)```

### Delete ALL images

```docker rmi $(docker images -q)```
