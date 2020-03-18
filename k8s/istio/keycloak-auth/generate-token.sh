#!/usr/bin/env bash

#CLIENT_SECRET="c48e7a0c-0f79-4d83-a531-1527c953a2fe"
#PUBLIC_IP="192.168.1.21"
#KEYCLOAK_HOST="http://keycloak.$PUBLIC_IP.nip.io:8080"

CLIENT_SECRET="df123f7f-1503-4b19-ba27-903138dc9156"
PUBLIC_IP=$(minikube ip)
KEYCLOAK_HOST="http://keycloak.$PUBLIC_IP.nip.io"

#PUBLIC_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

#echo $PUBLIC_IP

RESULT_TOKEN=`curl -s -X POST $KEYCLOAK_HOST/auth/realms/istio/protocol/openid-connect/token \
-d "client_secret=${CLIENT_SECRET}" \
-d "grant_type=client_credentials" \
-d "client_id=istio" \
-d "audience=istio"`

#echo ${RESULT_TOKEN}

TOKEN=`echo $RESULT_TOKEN | sed 's/.*access_token":"//g' | sed 's/".*//g'`
#echo $TOKEN

USERINFO=`curl -s -H "Authorization: Bearer $TOKEN" $KEYCLOAK_HOST/auth/realms/istio/protocol/openid-connect/userinfo`

export USERINFO
export RESULT_TOKEN
export TOKEN
export PUBLIC_IP
