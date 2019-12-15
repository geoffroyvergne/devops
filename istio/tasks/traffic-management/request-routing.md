# Request routing

https://istio.io/docs/tasks/traffic-management/request-routing/

## First deploy bookinfo app

## Apply a virtual service

kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml

## Test the new routing configuration

http://$GATEWAY_URL/productpage

## Route based on user identity

kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml

## Cleanup

kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl delete -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml