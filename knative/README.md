# Install Knative

## Run minikube

https://knative.dev/docs/install/knative-with-minikube/

minikube start --memory=8192 --cpus=6 \
  --kubernetes-version=v1.14.0 \
  --vm-driver=hyperkit \
  --disk-size=30g \
  --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"

minikube ip 

## Set up load balancer

minukube tunnel
minikube tunnel --cleanup

## Install Istio

https://istio.io/docs/setup/getting-started/

## Install Knative

https://knative.dev/docs/install/knative-with-minikube/

kubectl apply \
   --selector knative.dev/crd-install=true \
   --filename https://github.com/knative/serving/releases/download/v0.10.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.10.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.10.0/monitoring.yaml
   
kubectl apply \
   --filename https://github.com/knative/serving/releases/download/v0.10.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.10.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.10.0/monitoring.yaml
   
### Test installation

kubectl get pods --namespace knative-serving
kubectl get pods --namespace knative-eventing
kubectl get pods --namespace knative-monitoring

### Configuring DNS

kubectl edit cm config-domain --namespace knative-serving

## Get INGRESS IP

echo $(minikube ip):$(kubectl get svc istio-ingressgateway --namespace istio-system --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')

kubectl get svc istio-ingressgateway --namespace istio-system --output jsonpath="{.status.loadBalancer.ingress[*]['ip']}"

## Deploy an app

https://knative.dev/docs/serving/getting-started-knative-app/

### Deploy
cd deployments/helloworld-go
kubectl apply --filename service.yaml

### Get service details
kubectl get ksvc helloworld-go

### Test app

curl -v http://helloworld-go.default.192.168.64.5.xip.io

curl -v http://192.168.64.6 \
-H "Host: helloworld-go.default.example.com" \
-H "Content-Type: application/json"

### Clean up
kubectl delete --filename service.yaml

## logs

kubectl proxy
127.0.0.1:8001

### Kibana
http://localhost:8001/api/v1/namespaces/knative-monitoring/services/kibana-logging/proxy/app/kibana
