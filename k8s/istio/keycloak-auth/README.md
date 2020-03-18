# Keycloak Auth

## Install Istio

## Deploy Keycloak

kubectl create namespace keycloak
kubectl apply -f keycloak.yml

## Import keycloak realm

create realm istio && import realm-export.json

## Test

source ./generate-token.sh

## Test httpbin

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

curl -v httpbin.$INGRESS_HOST.nip.io/status/200

curl -v --request GET \
  --url http://httpbin.$INGRESS_HOST.nip.io/status/200 \
  --header "authorization: Bearer $TOKEN"
  
curl -H "Authorization: Bearer $TOKEN" http://httpbin.$INGRESS_HOST.nip.io/status/200

curl -v httpbin.$INGRESS_HOST.nip.io/status/418