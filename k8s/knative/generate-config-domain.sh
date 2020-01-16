#!/usr/bin/env bash

INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-domain
  namespace: knative-serving
data:
  # These are example settings of domain.
  # example.org will be used for routes having app=prod.
  example.org: |
    selector:
      app: prod
  $INGRESS_HOST.nip.io: |
    selector:
      app: nip
  $INGRESS_HOST.xip.io: |
    selector:
      app: xip
  # Default value for domain, for routes that does not have app=prod labels.
  # Although it will match all routes, it is the least-specific rule so it
  # will only be used if no other domain matches.

  #$INGRESS_HOST.nip.io: ""
  example.com: ""
EOF

echo "curl -v http://helloworld-go.default.$INGRESS_HOST.nip.io"