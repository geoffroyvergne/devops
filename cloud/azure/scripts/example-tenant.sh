#!/bin/bash

# https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-linux-cli-sample-create-vm-nsg

RESOURCE_GROUP="rsg-int-gver"
PREFIX="example"
USER="adminuser"

# Create a virtual network and front-end subnet.
az network vnet create \
  --resource-group ${RESOURCE_GROUP} \
  --name ${PREFIX}Vnet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name ${PREFIX}Subnet --subnet-prefix 10.0.1.0/24

# Create a front-end virtual machine.
az vm create \
  --resource-group ${RESOURCE_GROUP} \
  --name ${PREFIX}vm \
  --image UbuntuLTS \
  --admin-username ${USER} \
  --vnet-name ${PREFIX}Vnet \
  --subnet ${PREFIX}Subnet \
  --nsg ${PREFIX}NetworkSecurityGroup \
  --ssh-key-value @~/.ssh/id_rsa.pub \
  --no-wait

