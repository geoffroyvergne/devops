# ISTIO

https://istio.io/docs/setup/getting-started/

## Set up your platform

https://istio.io/docs/setup/platform-setup/minikube/

minikube config set vm-driver hyperkit
minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.14.2

## Set up load balancer

minukube tunnel
minikube tunnel --cleanup

## Download the release

cd data 
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.4.2

## Install Istio

./istio-1.4.2/bin/istioctl manifest apply --set profile=demo

kubectl get svc -n istio-system
kubectl get pods -n istio-system

## Enable istio injection

kubectl label namespace default istio-injection=enabled

## Uninstall

./istio-1.4.2/bin/istioctl manifest generate --set profile=demo | kubectl delete -f -

export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

## Ingress Gateway

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

echo http://GATEWAY_URL

## Dashboard

./istio-1.4.2/bin/istioctl dashboard <appli>