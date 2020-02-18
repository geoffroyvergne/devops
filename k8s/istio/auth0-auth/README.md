# Istio Auth0 authentication

https://auth0.com/blog/securing-kubernetes-clusters-with-istio-and-auth0/

git clone https://github.com/auth0-blog/istio-auth0

## Install minikube and istio

kubectl label namespace default istio-injection=enabled


## Deploy Bookinfo 

kubectl apply -f platform/kube/bookinfo.yaml
kubectl apply -f networking/bookinfo-gateway.yaml
kubectl apply -f networking/bookinfo-virtualservice.yaml

PUBLIC_IP=kubectl get svc \
  -n istio-system istio-ingressgateway \
  -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'
  
curl -v $PUBLIC_IP/productpage
curl -v http://bookinfo.$PUBLIC_IP.nip.io/productpage


## Authenticating Users with Istio and Auth0

kubectl apply -f security/bookinfo-policy.yaml
kubectl apply -f networking/destination-rule-mtls.yaml
kubectl apply -f networking/auth0-egress.yaml
