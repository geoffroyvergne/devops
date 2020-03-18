#!/usr/bin/env bash

PUBLIC_IP=$(minikube ip)
#PUBLIC_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

cat <<EOT > httpbin-policy-keycloak.yml

---

apiVersion: authentication.istio.io/v1alpha1
kind: Policy
metadata:
  name: policy
  namespace: istio-system
spec:
  targets:
    - name: istio-ingressgateway
  peers:
    - mtls: {}
  origins:
    - jwt:
        issuer: "http://keycloak.$PUBLIC_IP.nip.io/auth/realms/istio"
        jwksUri: "http://keycloak.$PUBLIC_IP.nip.io/auth/realms/istio/protocol/openid-connect/certs"
  principalBinding: USE_ORIGIN
EOT

cat httpbin-policy-keycloak.yml
