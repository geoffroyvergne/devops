#!/bin/bash

#NAMESPACE="testing"
NAMESPACE=$1

echo "Namespace : $NAMESPACE"

# Create namespace
kubectl create namespace $NAMESPACE

# Create role
cat <<EOF | kubectl create -f -
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $NAMESPACE-edit
  namespace: $NAMESPACE # This binding only applies in the namespace
subjects:
  - kind: Group # May be "User", "Group" or "ServiceAccount"
    name: $NAMESPACE
roleRef:
  kind: ClusterRole
  name: edit
  apiGroup: rbac.authorization.k8s.io
EOF

echo "Namespace created"
echo "./create-user-role.sh <username> <email>  $NAMESPACE"