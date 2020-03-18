# ISTIO

https://istio.io/docs/setup/getting-started/

## Set up your platform

https://istio.io/docs/setup/platform-setup/minikube/

```

echo "" > /var/db/dhcpd_leases

minikube config set vm-driver hyperkit
minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.14.2  

--uuid=0

minikube ip

minikube addons enable ingress
```

## Set up load balancer

```
minikube tunnel
minikube tunnel --cleanup

minikube tunnel &> /dev/null &
```

## Download the release

```
cd data 
curl -L https://istio.io/downloadIstio | sh -

sudo cp data/istio-<version>/bin/istioctl /usr/local/bin
```

## Install Istio

```
istioctl manifest apply --set profile=demo
istioctl manifest apply

istioctl manifest apply --set values.global.disablePolicyChecks=true

istioctl profile list

kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

## Enable istio injection

```
kubectl label namespace default istio-injection=enabled
```

## Uninstall

```
bin/istioctl manifest generate --set profile=demo | kubectl delete -f -

export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
```

## Ingress Gateway

```
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

echo http://$GATEWAY_URL
```

## Dashboard

```bin/istioctl dashboard <appli>```