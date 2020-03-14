#!/usr/bin/env bash

CLIENT_SECRET="faa38f37-85e5-4725-a544-971cc55f77ee"
PUBLIC_IP=$(minikube ip)
#PUBLIC_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo $PUBLIC_IP

RESULT_TOKEN=`curl -X POST http://keycloak.${PUBLIC_IP}.nip.io/auth/realms/istio/protocol/openid-connect/token \
-d "client_secret=${CLIENT_SECRET}" \
-d "grant_type=client_credentials" \
-d "client_id=istio" \
-d "audience=istio"`

#echo ${RESULT_TOKEN}

TOKEN=`echo $RESULT_TOKEN | sed 's/.*access_token":"//g' | sed 's/".*//g'`
#echo $TOKEN

USERINFO=`curl -H "Authorization: Bearer $TOKEN" http://keycloak.${PUBLIC_IP}.nip.io/auth/realms/istio/protocol/openid-connect/userinfo`

export USERINFO
export RESULT_TOKEN
export TOKEN
export PUBLIC_IP
