# Podman

https://www.redhat.com/sysadmin/replace-docker-podman-macos

brew install podman

podman search httpd --filter=is-official

export CONTAINER_HOST=ssh://vagrant@127.0.0.1:2222/run/podman/podman.sock
export CONTAINER_SSHKEY=$HOME/dev/devops/podman/.vagrant/machines/default/virtualbox/private_key