# Azure Kubernetes

https://docs.microsoft.com/fr-fr/azure/aks/intro-kubernetes

# Create cluster AKS

az aks create \
--resource-group rsg-int-gver \
--name myAKSCluster \
--node-count 1 \
--ssh-key-value ~/.ssh/id_rsa.pub \
--location westeurope

az aks list -o table

# Connecting Cluster

# Configure kubectl 

az aks get-credentials --resource-group rsg-int-gver --name myAKSCluster

kubectl get nodes

# Deploy app

kubectl apply -f azure-vote.yaml
kubectl get pods
kubectl get service azure-vote-front 

# Scale containers

kubectl scale --replicas=3 deployment/azure-vote-front

# Scale cluster

az aks scale --resource-group rsg-int-gver --name myAKSCluster --node-count 3

# Update k8s

az aks get-upgrades --resource-group rsg-int-gver --name myAKSCluster --output table
az aks upgrade --resource-group rsg-int-gver --name myAKSCluster --kubernetes-version 1.14.6
az aks show --resource-group rsg-int-gver --name myAKSCluster --output table

# Delete cluster

az aks delete --name myAKSCluster --resource-group rsg-int-gver
