# Micro K8S
https://ubuntu.com/tutorials/install-microk8s-on-mac-os#1-overview

brew install ubuntu/microk8s/microk8s

microk8s install
microk8s uninstall

microk8s status --wait-ready

## List add-ons

microk8s enable --help
microk8s enable dashboard dns registry istio

## Troubleshoot / prepare version

multipass exec microk8s-vm -- sudo snap list 
multipass exec microk8s-vm -- snap info microk8s
multipass exec microk8s-vm -- sudo snap install microk8s --classic --channel=latest/stable

# config

mkdir /Users/gv/.microk8s
microk8s config > /Users/gv/.microk8s/config

## Kubectl

microk8s kubectl get all --all-namespaces

## Deploy an app

microk8s kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
microk8s kubectl get pods

