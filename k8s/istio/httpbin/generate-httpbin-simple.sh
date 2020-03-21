#!/usr/bin/env bash

#PUBLIC_IP=$(minikube ip)
INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

cat <<EOT > httpbin-simple.yml

---

apiVersion: v1
kind: ServiceAccount
metadata:
  name: httpbin

---

apiVersion: v1
kind: Service
metadata:
  name: httpbin
  labels:
    app: httpbin
spec:
  ports:
    - name: http
      port: 8000
      targetPort: 80
  selector:
    app: httpbin

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
      version: v1
  template:
    metadata:
      labels:
        app: httpbin
        version: v1
    spec:
      serviceAccountName: httpbin
      containers:
        - image: docker.io/kennethreitz/httpbin
          imagePullPolicy: IfNotPresent
          name: httpbin
          ports:
            - containerPort: 8000

---

apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - "httpbin.$INGRESS_HOST.nip.io"

---

apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
    - "httpbin.$INGRESS_HOST.nip.io"
  gateways:
    - httpbin-gateway
  http:
    - match:
        - uri:
            prefix: /status
        - uri:
            prefix: /delay
      route:
        - destination:
            port:
              number: 8000
            host: httpbin

EOT

cat httpbin-simple.yml
