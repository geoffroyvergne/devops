# Bastion

https://medium.com/@shouldroforion/azure-terraform-some-quick-observations-through-a-weekend-of-failfastshareoften-9bffc310c372
https://medium.com/@shouldroforion/azure-terraform-part-1-building-a-basic-bastion-worker-host-virtual-network-c8bcc419cfc9

## Build and deploy the infrastructure

terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

## Get Ip and FQDN

export PUBLIC_IP=$(az network public-ip list -g rsg-int-gver --query '[].{PUBLICIP:ipAddress}' -o tsv)
export HOSTNAME=$(az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn}' -o tsv)

az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn, PUBLICIP:ipAddress}' -o table

## SSH 

## Login to bastion

ssh azureuser@$PUBLIC_IP
ssh azureuser@$HOSTNAME

ssh -F ./sshconfig bastion-bstn-vm001

## Copy private key to bastion and generate sshconfig

./setup-ssh.sh
 
## Login to the worker

ssh -F ./sshconfig bastion-wrkr-vm001

