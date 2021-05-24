# K3S

# k3d  => k3s wrapper
brew install k3d

k3d cluster create cluster

kubectl get nodes
kubectl get pods --all-namespaces

k3d cluster stop cluster
k3d cluster delete cluster
