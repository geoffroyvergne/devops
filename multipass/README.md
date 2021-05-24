# Canonical Multipass
https://multipass.run/

brew install --cask multipass

multipass find
multipass launch --name ubuntu-lts
multipass launch ubuntu-test
multipass launch focal --name focal

multipass launch focal -n focal --cloud-init cloud-config.yaml
multipass mount $HOME/dev focal:dev

multipass list

MULTIPASS_VM_IP=$(multipass info focal | grep 'IPv4' | awk '{print $2}')

multipass exec ubuntu-test -- /bin/bash
multipass shell ubuntu-test

multipass ubuntu-test
multipass delete ubuntu-test
multipass purge
