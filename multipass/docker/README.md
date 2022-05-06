# Multipass Docker

## Create VM
multipass launch --cloud-init - --disk 40G --mem 4G --cpus 4 --name docker <<EOF
groups:
- docker
snap:
  commands:
  - [install, docker]
runcmd:
- adduser ubuntu docker
EOF

## Add ssh key
cat ~/.ssh/id_rsa.pub  | multipass exec docker -- tee -a .ssh/authorized_keys

ssh -l ubuntu -- $(multipass info docker | grep 'IPv4' | awk '{print $2}')

ssh ubuntu@$(multipass info docker | grep 'IPv4' | awk '{print $2}')

# Export docker command
export DOCKER_HOST=ssh://ubuntu@$(multipass info docker | grep 'IPv4' | awk '{print $2}')



## Create alias
multipass alias docker:docker

multipass docker run hello-world

multipass docker ps
multipass docker ps -- -a
