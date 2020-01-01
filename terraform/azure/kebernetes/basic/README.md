# Kubernetes Basic

https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples/kubernetes/basic
https://www.hashicorp.com/blog/kubernetes-cluster-with-aks-and-terraform/

## Deploy
terraform plan \
-var "client_id=your_client_id" \
-var "client_secret=your_client_secret"

## Get outputs
terraform output host

## Configure k8s

echo "$(terraform output kube_config)" > ~/.kube/azurek8s

export KUBECONFIG=~/.kube/azurek8s

## Test

kubectl get nodes

## Dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

kubectl proxy

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

### Token

kubectl -n kube-system get secret
kubectl -n kube-system describe secret default-token-z9xvl

