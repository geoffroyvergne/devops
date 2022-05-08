# Terraform Azure

https://learn.hashicorp.com/terraform?track=azure#azure

## Configure access

az login
az account list
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId, clientId: clientId}"

az account list --all --query "[].id"

## get objectid

az ad user show --id geoffroy.vergne@cgi.com | jq -r .objectId


## Get DNS Name and ip

az network public-ip list -g rsg-int-gver --query '[].{ip:ipAddress, FQDN:dnsSettings.fqdn}' -o table
az network public-ip list -g rsg-int-gver --query '[].{ip:ipAddressn}' -o tsv
az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn}' -o tsv


## Get locations

az account list-locations

## Terraform

terraform init

terraform plan
terraform plan -out=newplan

terraform apply
terraform apply "newplan"
terraform apply -auto-approve 

terraform destroy
