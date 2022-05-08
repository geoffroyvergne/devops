# Simple VM

terraform plan
terraform apply
terraform show

terraform taint azurerm_virtual_machine.vm-1

## SSH 


az vm list-ip-addresses -o table
az vm list --query '[].{Name:name, admin:osProfile.adminUsername}' -o json -o table
az vm list --query '[].{Name:name}' -o json -o table


az vm show -d -g rsg-int-gver -n simple-vm-1 --query publicIps -o tsv
az vm show -d -g rsg-int-gver -n simple-vm-1 --query privateIps -o tsv
az vm show -d -g rsg-int-gver -n simple-vm-1 --query osProfile.adminUsername -o tsv

ssh azureuser@40.114.230.32

ssh $(az vm show -d -g rsg-int-gver -n simple-vm-1 --query osProfile.adminUsername -o tsv)@$(az vm show -d -g rsg-int-gver -n simple-vm-1 --query publicIps -o tsv)

## Stop VM

az vm stop --resource-group rsg-int-gver --name simpleVM

## Stop All VM

az vm stop --ids $(az vm list -g rsg-int-gver --query "[].id" -o tsv)
