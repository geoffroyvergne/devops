# Azure Kubernetes

https://docs.microsoft.com/fr-fr/azure/aks/intro-kubernetes

# List Kubernetes versions

az aks get-versions --location westeurope --output table

# Create cluster AKS

az aks create \
--resource-group rsg-int-gver \
--name aKSCluster \
--node-count 1 \
--kubernetes-version 1.14.8 \
--ssh-key-value ~/.ssh/id_rsa.pub \
--location westeurope

--node-vm-size  Standard_DS2_v2
--node-osdisk-size 30 GB
--kubernetes-version 1.14.8
--vm-set-type AvailabilitySet
--load-balancer-managed-outbound-ip-count 2

az aks list -o table

# Connecting Cluster

# Configure kubectl 

az aks get-credentials --resource-group rsg-int-gver --name aKSCluster

kubectl get nodes

# Ingress

https://docs.microsoft.com/en-us/azure/dev-spaces/how-to/ingress-https-nginx

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

kubectl create ns nginx
helm install nginx stable/nginx-ingress --namespace nginx --version 1.27.0

kubectl get svc -n nginx --watch

export PUBLIC_IP=$(kubectl get svc nginx-nginx-ingress-controller -n nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $PUBLIC_IP

az network dns record-set a add-record \
    --resource-group myResourceGroup \
    --zone-name gverAks \
    --record-set-name '*.nginx' \
    --ipv4-address $PUBLIC_IP

# Deploy app

kubectl apply -f azure-vote.yaml
kubectl get pods
kubectl get service azure-vote-front 

# Scale containers

kubectl scale --replicas=3 deployment/azure-vote-front

# Scale cluster

az aks scale --resource-group rsg-int-gver --name aKSCluster --node-count 3

# Update k8s

az aks get-upgrades --resource-group rsg-int-gver --name aKSCluster --output table
az aks upgrade --resource-group rsg-int-gver --name aKSCluster --kubernetes-version 1.14.6
az aks show --resource-group rsg-int-gver --name aKSCluster --output table

# Delete cluster

az aks delete --name aKSCluster --resource-group rsg-int-gver
