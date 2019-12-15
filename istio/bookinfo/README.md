# BookInfo

https://istio.io/docs/examples/bookinfo/

## Deploy app

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

kubectl get services
kubectl get pods

## Test

kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"

## Gateway

kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get gateway

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo $GATEWAY_URL

curl -s http://$GATEWAY_URL/productpage | grep -o "<title>.*</title>"

## Apply default destination rules

kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml

## Cleanup

kubectl delete -f samples/bookinfo/networking/destination-rule-all.yaml
kubectl delete -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl delete -f samples/bookinfo/platform/kube/bookinfo.yaml


