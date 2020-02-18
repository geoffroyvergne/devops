# Istio enduser authentication

https://mymusictaste.github.io/2019/10/07/end-user-auth-with-istio-keycloak-eks.html

## Deploy keycloak

## Keycloak settings

create realm istio
token rs256

create client istio
openidcinnect
accesstype confidential

## Create the foo namespace

kubectl create ns foo

## Deploy httpbin and sleep service in the foo namespace

kubectl apply -f samples/httpbin/httpbin.yaml
kubectl apply -f samples/sleep/sleep.yaml

kubectl apply -f samples/httpbin/httpbin-gateway.yaml


## Create policies

./generate-auth-policies.sh

## Test

### Get access token

source ./generate-token.sh

### Test requesting the httpbin service from the public

curl -H "Authorization: Bearer $TOKEN" http://keycloak.$PUBLIC_IP.nip.io/auth/realms/istio/protocol/openid-connect/userinfo

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

curl -v http://$INGRESS_HOST/headers
curl -v -H "Authorization: Bearer $TOKEN" http://$INGRESS_HOST/headers

### Test requesting the httpbin service from the sleep service

kubectl exec $(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name}) -c sleep -- curl -v http://httpbin:8000/ip
