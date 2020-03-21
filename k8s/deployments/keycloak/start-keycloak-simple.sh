#!/usr/bin/env bash

./generate-ingress-minikube.sh

kubectl create namespace keycloak

kubectl apply -f keycloak.yml
kubectl apply -f ingress-keycloak.yml

echo "curl -v keycloak.$(minikube ip).nip.io"
echo "kubectl get pods -n keycloak"
echo "kubectl get svc -n keycloak"
echo "kubectl describe $(kubectl get pods -n keycloak -l app=keycloak -o=name) -n keycloak"
