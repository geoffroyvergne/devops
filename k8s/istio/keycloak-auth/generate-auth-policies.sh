#!/usr/bin/env bash

PUBLIC_IP=$(minikube ip)

cat <<EOF | kubectl apply -f -
---

## Globally enabling Istio mutual TLS
# Mesh policies

apiVersion: "authentication.istio.io/v1alpha1"
kind: "MeshPolicy"
metadata:
  name: "default"
spec:
  peers:
    - mtls: {}

---

## Config the client-side (the requesting services) to use mTLS
# Destination rules

apiVersion: "networking.istio.io/v1alpha3"
kind: "DestinationRule"
metadata:
  name: "default"
  namespace: "istio-system"
spec:
  host: "*.local"
  trafficPolicy:
    tls:
      mode: ISTIO_MUTUAL

---

## Apply the policy to add end-user authentication
# Policy

apiVersion: "authentication.istio.io/v1alpha1"
kind: "Policy"
metadata:
  name: "jwt-keycloak"
spec:
  targets:
    - name: httpbin
      ports:
      - number: 8000
  peers:
    - mtls: {}
  origins:
    - jwt:
        issuer: "http://keycloak.$PUBLIC_IP.nip.io/auth/realms/istio"
        jwksUri: "http://keycloak.$PUBLIC_IP.nip.io/auth/realms/istio/protocol/openid-connect/certs"
        #audiences:
        #  - istio
  principalBinding: USE_ORIGIN
EOF

