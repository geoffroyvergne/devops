# Terraform Azure

https://learn.hashicorp.com/terraform?track=azure#azure

## Configure access

az login
az account list
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"

## Get locations

az account list-locations

## Terraform

terraform init

terraform plan
terraform plan -out=newplan

terraform apply
terraform apply "newplan"

terraform destroy
