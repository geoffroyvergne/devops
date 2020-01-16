# Fault injection

https://istio.io/docs/tasks/traffic-management/fault-injection/

## First deploy bookinfo app

## Apply a virtual service

kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml

## Injecting an HTTP delay fault

kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml

