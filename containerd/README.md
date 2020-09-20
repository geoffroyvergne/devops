# containerd

https://containerd.io/docs/getting-started/
https://containerd.io/downloads/

## Launch ubuntu

multipass launch focal -n ubuntudev --cloud-init ../multipass/dev.yml
multipass mount $HOME/dev ubuntudev:dev
multipass exec ubuntudev -- /bin/bash

## bin
wget https://github.com/containerd/containerd/releases/download/v1.3.4/containerd-1.3.4.linux-amd64.tar.gz
tar xvf containerd-1.3.4.linux-amd64.tar.gz

## source
wget https://github.com/containerd/containerd/archive/v1.3.4.zip
unzip v1.3.4.zip

## generate config
bin/containerd config default > etc/config.toml

## run
bin/containerd etc/config.toml

## Configure go environment

export GOPATH=$HOME/go
export GOROOT=/usr/lib/go-1.13
 
mkdir -p $HOME/go/src/containerd

dep init
go build main.go

