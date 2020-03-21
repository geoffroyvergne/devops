#!/usr/bin/env bash

INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

cat <<EOT > istio-gateway.yml
---

apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: keycloak-gateway
  namespace: keycloak
spec:
  selector:
    istio: ingressgateway
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - "keycloak.$INGRESS_HOST.nip.io"

---

apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: keycloak
spec:
  hosts:
    - "keycloak.$INGRESS_HOST.nip.io"
  gateways:
    - keycloak-gateway
  http:
    - match:
        - uri:
            prefix: /auth
      route:
        - destination:
            port:
              number: 8080
            host: keycloak

EOT

cat istio-gateway.yml