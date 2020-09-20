# Canonical Multipass
https://multipass.run/

multipass find
multipass launch --name ubuntu-lts
multipass launch focal
multipass launch focal --name focal

multipass launch focal -n focal --cloud-init cloud-config.yaml
multipass mount $HOME/dev focal:dev

multipass list

MULTIPASS_VM_IP=$(multipass info focal | grep 'IPv4' | awk '{print $2}')


multipass exec focal -- /bin/bash