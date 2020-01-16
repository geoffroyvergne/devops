# K8S

## Start Minikube

```
minikube config set vm-driver hyperkit
minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.14.2

minikube start \
--vm-driver=kvm2 \
--docker-env HTTP_PROXY=http://10.237.4.220:3128 \
--docker-env NO_PROXY=192.168.0.0/16

export NO_PROXY="localhost,127.0.0.0/8,::1,$(minikube ip),demoapp"
export no_proxy="localhost,127.0.0.0/8,::1,$(minikube ip),demoapp"

minikube addons enable ingress

minikube tunnel

```

## Test installation

```
---

kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-minikube --type=NodePort --port=8080
minikube service hello-minikube

kubectl delete services hello-minikube
kubectl delete deployment hello-minikube

---
```

## Deploy demo app

```
minikube ssh
sudo mkdir /data/demoapp

minikube ssh 'sudo mkdir /data/demoapp' 

kubectl get pods -n kube-system

kubectl apply -f base.yml
kubectl apply -f local-volume.yml
kubectl apply -f postgres.yml
kubectl apply -f backend.yml
kubectl apply -f frontend.yml
```

### Scale app

```kubectl scale --replicas=3 deployment/backend -n demoapp```

### Test app

```
minikube service frontend -n demoapp
curl -v $(minikube service frontend --url -n demoapp)

curl -v $(minikube service backend --url -n demoapp)/api/backend/index/test

curl -v -H Host:demoapp $(minikube ip)
```

### Delete app

```
kubectl delete deployment demo-front
kubectl delete services demo-front
```
