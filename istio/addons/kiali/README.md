# Kiali

https://preliminary.istio.io/docs/tasks/observability/kiali

## Enable Kiali

./bin/istioctl manifest apply --set values.kiali.enabled=true

## Create secret

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
type: Opaque
data:
  username: "YWRtaW4="
  passphrase: "YWRtaW4="
EOF

## Restart Kiali

kubectl -n istio-system delete pod $(kubectl -n istio-system get pod -l "app=kiali" -o jsonpath='{.items[0].metadata.name}')

## Start Dashboard

./bin/istioctl dashboard kiali

## Generate traffic

watch -n 1 curl -o /dev/null -s -w %{http_code} $GATEWAY_URL/productpage

