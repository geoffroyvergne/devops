# bookinfo tls multiple hosts

## Create a server certificate and private key

openssl req -out bookinfo.com.csr -newkey rsa:2048 -nodes -keyout bookinfo.com.key -subj "/CN=bookinfo.com/O=bookinfo organization"
openssl x509 -req -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 0 -in bookinfo.com.csr -out bookinfo.com.crt

### Create secret
kubectl create -n istio-system secret tls istio-ingressgateway-bookinfo-certs --key bookinfo.com.key --cert bookinfo.com.crt

### Apply patch
kubectl -n istio-system patch --type=json deploy istio-ingressgateway -p "$(cat ../gateway-patch-bookinfo.json)"

## Check crt exists
kubectl exec -it -n istio-system $(kubectl -n istio-system get pods -l istio=ingressgateway -o jsonpath='{.items[0].metadata.name}') -- ls -al /etc/istio/ingressgateway-bookinfo-certs

## Configure traffic for the bookinfo.com host

