#!/usr/bin/env bash

USERNAME=azureuser
BASTION_NAME=bastion-bstn-vm001
WORKER_1=bastion-wrkr-vm001

# Get FQDN Hostname
HOSTNAME=$(az network public-ip list -g rsg-int-gver --query '[].{FQDN:dnsSettings.fqdn}' -o tsv)

echo "Public FQDN for Bastion ${BASTION_NAME} : ${HOSTNAME}"

# Get Bastion public IP
PUBLIC_IP=$(az network public-ip list -g rsg-int-gver --query '[].{PUBLICIP:ipAddress}' -o tsv)

echo "Public Ip for Bastion ${BASTION_NAME} : ${PUBLIC_IP}"

## Copy private key to bastion
scp ~/.ssh/id_rsa ${USERNAME}@${PUBLIC_IP}:~/.ssh/id_rsa

# Generate sshconfig file

cat <<EOF >sshconfig
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null

Host ${BASTION_NAME}
  Hostname ${HOSTNAME}
  User ${USERNAME}

Host ${WORKER_1}
  ProxyJump ${BASTION_NAME}
  Hostname ${WORKER_1}
  User ${USERNAME}
EOF


echo "login to worker : ssh -F ./sshconfig ${WORKER_1}"
