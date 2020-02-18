#!/usr/bin/env bash

PUBLIC_IP=$(minikube ip)

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: ingress
  namespace: keycloak
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/service-upstream: "true"
spec:
  rules:
    - host: keycloak.$PUBLIC_IP.nip.io
      http:
        paths:
          - path: /
            backend:
              serviceName: keycloak
              servicePort: 8080
EOF

echo "curl -v http://keycloak.$PUBLIC_IP.nip.io"
