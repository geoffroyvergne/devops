# Azure container registry

https://docs.microsoft.com/fr-fr/azure/aks/tutorial-kubernetes-prepare-acr

# Create container registry

az acr create --resource-group rsg-int-gver --name myACRGVER --sku Basic

az acr list -o table

# Login

az acr login --name myACRGVER

# Tag image

## Get server host

az acr list --resource-group rsg-int-gver --query "[].{acrLoginServer:loginServer}" --output table

docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v1

docker push <acrLoginServer>/azure-vote-front:v1

# List images

az acr repository list --name myACRGVER --output table

# Delete

az acr delete --name myACRGVER --resource-group rsg-int-gver