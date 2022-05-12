# Multipass Microk8s

# Launch VM
multipass launch --cloud-init - --disk 40G --mem 4G --cpus 4 --name microk8s <<EOF
runcmd:
- iptables -P FORWARD ACCEPT
- snap install microk8s --classic --channel=1.18/stable
- usermod -a -G microk8s ubuntu
- chown -f -R ubuntu /home/ubuntu/.kube
EOF

multipass launch --disk 40G --mem 4G --cpus 4 --name microk8s

## Get vm IP
K8S_IP=$(multipass info microk8s | grep IPv4 | awk '{print $2}')
echo $K8S_IP

multipass exec microk8s -- sudo snap install microk8s --classic --channel=1.18/stable
multipass exec microk8s -- sudo usermod -a -G microk8s ubuntu
multipass exec microk8s -- sudo chown -f -R ubuntu ~/.kube

# Microk8s commands

## From Shell
multipass shell microk8s

microk8s enable --help
microk8s enable dashboard dns registry istio
microk8s dashboard-proxy

microk8s kubectl get nodes
microk8s kubectl get all -A

## From multipass
multipass alias microk8s:microk8s

multipass microk8s kubectl get nodes
multipass microk8s kubectl get all -- -A