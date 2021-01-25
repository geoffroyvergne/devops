# Kyma

https://kyma-project.io/

## install 
brew install kyma-cli

sudo chown root:wheel /Users/gv/.minikube/bin/docker-machine-driver-hyperkit 
sudo chmod u+s /Users/gv/.minikube/bin/docker-machine-driver-hyperkit 
sudo chown -R $USER $HOME/.minikube; chmod -R u+wrx $HOME/.minikube

kyma provision minikube

kyma install --source 1.17.0
kyma version
kyma upgrade -s {VERSION}

## Kyma console 
kyma console
https://console.kyma.local/

login : admin@kyma.cx
password : printed in the terminal 

### login 
kubectl get secret admin-user -n kyma-system -o jsonpath="{.data.email}"  | base64 --decode

### password 
kubectl get secret admin-user -n kyma-system -o jsonpath="{.data.password}" | base64 --decode

## stop
minikube stop

## restart
kyma provision minikube

https://kyma-project.io/docs/root/getting-started/

