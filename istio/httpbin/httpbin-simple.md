# httpbin simple

## Deploy 
kubectl apply -f <(./istio-1.4.2/bin/istioctl kube-inject -f ../httpbin/httpbin-simple.yml)

## Test

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

curl -v httpbin.10.109.207.16.nip.io/status/200
curl -v httpbin.10.109.207.16.nip.io/status/418

## CleanUp

kubectl delete --ignore-not-found=true -f ../httpbin/httpbin-simple.yml

