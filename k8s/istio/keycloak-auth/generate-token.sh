#!/usr/bin/env bash

PUBLIC_IP=$(minikube ip)
echo $PUBLIC_IP

RESULT_TOKEN=`curl -X POST http://keycloak.${PUBLIC_IP}.nip.io/auth/realms/istio/protocol/openid-connect/token \
-d "client_secret=76cc6c94-f88b-4c2c-b499-924b113940db" \
-d "grant_type=client_credentials" \
-d "client_id=istio" \
-d "audience=istio"`

echo ${RESULT_TOKEN}

TOKEN=`echo $RESULT_TOKEN | sed 's/.*access_token":"//g' | sed 's/".*//g'`
#echo $TOKEN

curl -H "Authorization: Bearer $TOKEN" http://keycloak.${PUBLIC_IP}.nip.io/auth/realms/istio/protocol/openid-connect/userinfo

export TOKEN
export PUBLIC_IP
