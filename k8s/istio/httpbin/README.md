# HttpBin

https://istio.io/docs/tasks/traffic-management/ingress/ingress-control/

## Install

kubectl apply -f <(istioctl kube-inject -f istio-1.4.2/samples/httpbin/httpbin.yaml)

kubectl apply -f - <<EOF
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
    - "httpbin.example.com"
    - "httpbin.10.109.207.16.nip.io"
EOF

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "httpbin.example.com"
  - "httpbin.10.109.207.16.nip.io"
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
EOF

## Test

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

curl -I -HHost:httpbin.example.com http://$INGRESS_HOST:$INGRESS_PORT/status/200
curl -I -HHost:httpbin.example.com http://$INGRESS_HOST:$INGRESS_PORT/delay/1

curl -I -HHost:httpbin.example.com http://$INGRESS_HOST:$INGRESS_PORT/headers
returns 404

curl -v httpbin.10.109.207.16.nip.io/status/200
curl -v httpbin.10.109.207.16.nip.io/delay/1

## Cleanup

kubectl delete gateway httpbin-gateway
kubectl delete virtualservice httpbin
kubectl delete --ignore-not-found=true -f istio-1.4.2/samples/httpbin/httpbin.yaml

## Debug

kubectl logs -f $(kubectl get pods -l app=httpbin -o=name)
kubectl exec -ti $(kubectl get pods -l app=httpbin -o=name) bash