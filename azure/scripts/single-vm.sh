#!/bin/bash

RESOURCE_GROUP="rsg-int-gver"
PREFIX="single"
USER="adminuser"

az vm create \
  --resource-group ${RESOURCE_GROUP} \
  --name ${PREFIX}vm \
  --image UbuntuLTS \
  --admin-username ${USER} \
  --size Standard_DS1_v2 \
  --ssh-key-value @~/.ssh/id_rsa.pub \
  --no-wait

