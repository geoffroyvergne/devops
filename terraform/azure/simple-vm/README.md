# Simple VM

terraform plan
terraform apply
terraform show

## SSH 


az vm list-ip-addresses -o table
az vm list --query '[].{Name:name, admin:osProfile.adminUsername}' -o json -o table

az vm show -d -g rsg-int-gver -n simpleVM --query publicIps -o tsv
az vm show -d -g rsg-int-gver -n simpleVM --query privateIps -o tsv
az vm show -d -g rsg-int-gver -n simpleVM --query osProfile.adminUsername -o tsv

ssh azureuser@137.117.228.10

## Stop VM

az vm stop --resource-group rsg-int-gver --name simpleVM

## Stop All VM

az vm stop --ids $(az vm list -g rsg-int-gver --query "[].id" -o tsv)
