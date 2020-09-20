# Micro K8S

brew install ubuntu/microk8s/microk8s

microk8s install
microk8s uninstall

microk8s status --wait-ready

## List add-ons

microk8s enable --help

## Troubleshoot

multipass exec microk8s-vm -- sudo snap list 
multipass exec microk8s-vm -- sudo snap install microk8s --classic --channel=1.18/stable

## Kubectl

microk8s kubectl get all --all-namespaces

