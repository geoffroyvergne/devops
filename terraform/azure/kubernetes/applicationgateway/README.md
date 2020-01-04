# Kubernetes application gateway

https://docs.microsoft.com/fr-fr/azure/terraform/terraform-create-k8s-cluster-with-aks-applicationgateway-ingress

## Deploy

terraform init
terraform plan -out out.plan
terraform apply out.plan

## Kubernetes

echo "$(terraform output kube_config)" > ./azurek8s
export KUBECONFIG=./azurek8s
kubectl get nodes

## Install azure ad pod identity

kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment.yaml

## Install HELM

helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update

## Install helm chart entry controller

wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/sample-helm-config.yaml -O helm-config.yaml
helm install -f helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure

kubectl apply -f app-gateway.yml

## Deploy example app

kubectl apply -f aspnetapp.yaml

## Set up AAD Pod Identity

https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#set-up-aad-pod-identity

az identity create -g rsg-int-gver -n myidentity
az identity show -g rsg-int-gver -n myidentity


az network application-gateway list --query '[].id'

az role assignment create \
    --role Contributor \
    --assignee bac0d3be-baa8-4d8f-9bb7-10ab46a06200 \
    --scope "/subscriptions/9f514960-7f6b-48d8-9038-1b332f45c148/resourceGroups/rsg-int-gver/providers/Microsoft.Network/applicationGateways/ApplicationGateway1"
    
az group list --query '[].id'

az role assignment create \
    --role Reader \
    --assignee bac0d3be-baa8-4d8f-9bb7-10ab46a06200 \
    --scope "/subscriptions/9f514960-7f6b-48d8-9038-1b332f45c148/resourceGroups/rsg-int-gver"
    
