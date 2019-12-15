# httpbin tls multiple hosts

## Create a server certificate and private key

openssl req -out nip.io.csr -newkey rsa:2048 -nodes -keyout nip.io.key -subj "/CN=*.nip.io/O=nip organization"
openssl x509 -req -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 0 -in nip.io.csr -out nip.io.crt

### Create secret
kubectl create -n istio-system secret tls istio-ingressgateway-nip-certs --key nip.io.key --cert nip.io.crt
kubectl delete -n istio-system secret tls istio-ingressgateway-nip-certs

### Apply patch
kubectl -n istio-system patch --type=json deploy istio-ingressgateway -p "$(cat ../gateway-patch-nip.json)"

## Check crt exists
kubectl exec -it -n istio-system $(kubectl -n istio-system get pods -l istio=ingressgateway -o jsonpath='{.items[0].metadata.name}') -- ls -al /etc/istio/ingressgateway-nip-certs

## Deploy 
kubectl apply -f <(./istio-1.4.2/bin/istioctl kube-inject -f ../httpbin/httpbin-tls-nip.yml)

## Test

curl -v --cacert example.com.crt https://httpbin.10.109.207.16.nip.io/status/418
curl -kv https://httpbin.10.109.207.16.nip.io/status/418

curl -v --cacert example.com.crt https://httpbin.10.109.207.16.nip.io/status/418

curl -v -HHost:bookinfo.com --resolve bookinfo.com:$SECURE_INGRESS_PORT:$INGRESS_HOST --cacert example.com.crt https://bookinfo.com:$SECURE_INGRESS_PORT/status/418



## CleanUp

kubectl delete --ignore-not-found=true -f ../httpbin/httpbin-tls-nip.yml