# Azure vm

az vm create \
  --resource-group rsg-int-gver \
  --name ubuntuvm \
  --image UbuntuLTS \
  --admin-username adminuser \
  --size Standard_DS1_v2 \
  --ssh-key-value @~/.ssh/id_rsa.pub \
  --no-wait

  --generate-ssh-keys \

az vm delete --resource-group rsg-int-gver --name ubuntuvm

az vm open-port --port 80 --resource-group rsg-int-gver --name ubuntuvm

ssh adminuser@13.80.139.213
ssh adminuser@ubuntuvm.westeurope.cloudapp.azure.com

az vm list-ip-addresses -o table

az vm list
az vm list --query '[].{Name:name}' -o json -o table

az vm list --query '[].{Name:name, admin:osProfile.adminUsername}' -o json -o table