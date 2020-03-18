# Istio policy auth

TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.5/security/tools/jwt/samples/demo.jwt -s) && echo $TOKEN | cut -d '.' -f2 - | base64 -d -

## Test httpbin

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

curl -v httpbin.$INGRESS_HOST.nip.io/status/200

curl -v --request GET \
  --url http://httpbin.$INGRESS_HOST.nip.io/status/200 \
  --header "authorization: Bearer $TOKEN"