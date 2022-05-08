# Application Gateway

https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html

terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

## Get Ip and FQDN

az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn, PUBLICIP:ipAddress}' -o table

export PUBLIC_IP=$(az network public-ip list -g rsg-int-gver --query '[].{PUBLICIP:ipAddress}' -o tsv)
export HOSTNAME=$(az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn}' -o tsv)




