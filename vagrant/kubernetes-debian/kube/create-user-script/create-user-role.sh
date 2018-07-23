#!/bin/bash

#USERNAME="janwillies"
USERNAME=$1
#EMAIL="janwillies@kubernetes"
EMAIL=$2
#NAMESPACE="testing"
NAMESPACE=$3

# Create certificats
openssl genrsa -out ~/k8s/$USERNAME.key 2048
openssl req -new -key ~/k8s/$USERNAME.key -out ~/k8s/$USERNAME.csr -subj "/CN=$USERNAME/O=$NAMESPACE"
sudo openssl x509 -req -in ~/k8s/$USERNAME.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out ~/k8s/$USERNAME.crt -days 10000

# Create config
cat <<EOF > ~/k8s/$USERNAME
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $(cat /etc/kubernetes/pki/ca.crt | base64 --wrap=0)
    server: https://192.168.33.13:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    namespace: $NAMESPACE
    user: $USERNAME
  name: $EMAIL
current-context: $EMAIL
kind: Config
preferences: {}
users:
- name: $USERNAME
  user:
    client-certificate-data: $(cat ~/k8s/$USERNAME.crt | base64 --wrap=0)
    client-key-data: $(cat ~/k8s/$USERNAME.key | base64 --wrap=0)
EOF

echo "User created"
echo "export KUBECONFIG=~/k8s/$USERNAME"

echo "kubectl run --image nginx"
echo "kubectl get all"

