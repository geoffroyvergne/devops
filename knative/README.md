# Install Knative

## Run minikube

https://knative.dev/docs/install/knative-with-minikube/

minikube start --memory=8192 --cpus=6 \
  --kubernetes-version=v1.14.0 \
  --vm-driver=hyperkit \
  --disk-size=30g \
  --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"

minikube ip 

## Install Helm

## Install Istio

https://knative.dev/docs/install/installing-istio/

cd data

### Download istio

export ISTIO_VERSION=1.1.7
curl -L https://git.io/getLatestIstio | sh -
cd istio-${ISTIO_VERSION}

### Install CRDs

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done

### Create istio-system namespace

cat <<EOF | kubectl apply -f -
   apiVersion: v1
   kind: Namespace
   metadata:
     name: istio-system
     labels:
       istio-injection: disabled
EOF
   
### Installing Istio without sidecar injection

#### A lighter template, with just pilot/gateway.
#### Based on install/kubernetes/helm/istio/values-istio-minimal.yaml

```
helm template --namespace=istio-system \
  --set prometheus.enabled=false \
  --set mixer.enabled=false \
  --set mixer.policy.enabled=false \
  --set mixer.telemetry.enabled=false \
  `# Pilot doesn't need a sidecar.` \
  --set pilot.sidecar=false \
  --set pilot.resources.requests.memory=128Mi \
  `# Disable galley (and things requiring galley).` \
  --set galley.enabled=false \
  --set global.useMCP=false \
  `# Disable security / policy.` \
  --set security.enabled=false \
  --set global.disablePolicyChecks=true \
  `# Disable sidecar injection.` \
  --set sidecarInjectorWebhook.enabled=false \
  --set global.proxy.autoInject=disabled \
  --set global.omitSidecarInjectorConfigMap=true \
  --set gateways.istio-ingressgateway.autoscaleMin=1 \
  --set gateways.istio-ingressgateway.autoscaleMax=2 \
  `# Set pilot trace sampling to 100%` \
  --set pilot.traceSampling=100 \
  install/kubernetes/helm/istio \
> ./istio-lean.yaml
```

kubectl apply -f istio-lean.yaml

### Verifying your Istio install

kubectl get pods --namespace istio-system

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

kubectl patch svc istio-ingressgateway --namespace istio-system --patch '{"spec": { "externalIPs": ["192.168.64.5"] }}'


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
