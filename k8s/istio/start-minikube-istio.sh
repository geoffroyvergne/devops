#!/usr/bin/env bash

minikube config set vm-driver hyperkit && \
minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.14.2 && \

minikube addons enable ingress && \

istioctl manifest apply --set profile=demo
#istioctl manifest apply --set values.global.disablePolicyChecks=true


echo "kubectl get pods -n istio-system"
echo "kubectl get svc -n istio-system"
