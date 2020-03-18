# Istio Auth0 authentication

https://programmaticponderings.com/2019/01/06/securing-kubernetes-withistio-end-user-authentication-using-json-web-tokens-jwt/

# Deploy httpbin

# Test

curl -v --request GET \
  --url http://httpbin.$INGRESS_HOST.nip.io/status/200 \
  --header "authorization: Bearer $TOKEN"