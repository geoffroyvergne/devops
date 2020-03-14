# K8S Keycloak

## Create namespace

kubectl create namespace keycloak
kubectl apply -f namespace.yml

## Keycloak simple

### Deploy keycloak

kubectl apply -f keycloak.yml
istioctl kube-inject -f keycloak.yml | kubectl apply -f -

## Ingress (do not use istio)

./generate-ingress-minikube.sh
kubectl apply -f ingress-keycloak.yml

## Get pod by name

kubectl get pods -n keycloak -l app=keycloak -o=name
kubectl get $(kubectl get pods -n keycloak -l app=keycloak -o=name) -n keycloak
kubectl describe $(kubectl get pods -n keycloak -l app=keycloak -o=name) -n keycloak
kubectl logs $(kubectl get pods -n keycloak -l app=keycloak -o=name) -n keycloak
kubectl logs -f $(kubectl get pods -n keycloak -l app=keycloak -o=name) -n keycloak

## Backup

kubectl exec -it \
$(kubectl get pod -l app=keycloak -o jsonpath='{.items[0].metadata.name}' -n keycloak) \
-n keycloak bash
 
kubectl exec -it $(kubectl get pod -l app=keycloak -o jsonpath='{.items[0].metadata.name}' -n keycloak) -n keycloak bash

/opt/jboss/keycloak/bin/standalone.sh \
-Dkeycloak.migration.action=export \
-Dkeycloak.migration.provider=dir \
-Dkeycloak.migration.dir=/opt/jboss/keycloak-export \
-Dkeycloak.migration.usersExportStrategy=DIFFERENT_FILES \
-Dkeycloak.migration.usersPerFile=100 \
-Djboss.socket.binding.port-offset=100

kubectl -n keycloak cp $(kubectl get pod -l app=keycloak -o jsonpath='{.items[0].metadata.name}' -n keycloak):/opt/jboss/keycloak-export .

## Restore

kubectl -n keycloak cp . $(kubectl get pod -l app=keycloak -o jsonpath='{.items[0].metadata.name}' -n keycloak):/opt/jboss/keycloak-export

kubectl exec -it $(kubectl get pod -l app=keycloak -o jsonpath='{.items[0].metadata.name}' -n keycloak) -n keycloak bash

/opt/jboss/keycloak/bin/standalone.sh \
-Dkeycloak.migration.action=import \
-Dkeycloak.migration.provider=dir \
-Dkeycloak.migration.dir=/opt/jboss/keycloak-export \
-Dkeycloak.migration.usersExportStrategy=DIFFERENT_FILES \
-Dkeycloak.migration.usersPerFile=100 \
-Djboss.socket.binding.port-offset=100 \
-Dkeycloak.migration.realmName=test

## Delete

kubectl delete service,deployment,ing -n keycloak

## Run image

docker run -it --rm -p 8080:8080 jboss/keycloak

## Keycloak postgres

kubectl apply -f keycloak-postgres/secret.yml

### Postgres local volume

kubectl apply -f keycloak-postgres/local-volume.yml
kubectl apply -f keycloak-postgres/postgres-local-volume.yml

### Postgres simple

kubectl apply -f keycloak-postgres/postgres.yml

### Deploy keycloak

kubectl apply -f keycloak-postgres/keycloak.yml
istioctl kube-inject -f keycloak.yml | keycloak-postgres/kubectl apply -f -