# Multipass K3s

## Run VM
multipass launch --name k3s --cpus 4 --mem 4g --disk 20g
multipass info k3s

## Install K3S
multipass exec k3s -- bash -c "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -"

## Get vm IP
K3S_IP=$(multipass info k3s | grep IPv4 | awk '{print $2}')
echo $K3S_IP

## Get kubeconfig
multipass exec k3s sudo cat /etc/rancher/k3s/k3s.yaml > data/k3s.yaml
cat k3s.yaml

## SED mac
sed -i '' "s/127.0.0.1/${K3S_IP}/" data/k3s.yaml

## GNU SED
sed -i "s/127.0.0.1/${K3S_IP}/" data/k3s.yaml

export KUBECONFIG=${PWD}/data/k3s.yaml

## Test Kubectl
kubectl get nodes