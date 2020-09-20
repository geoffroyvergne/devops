# Cloudera manager

## Install POC

vagrant up
vagrant ssh

echo '192.168.33.10 cloudera-host' | sudo tee -a /etc/hosts

https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cm_ig_non_production.html

````
wget https://archive.cloudera.com/cm6/6.3.1/cloudera-manager-installer.bin

chmod u+x cloudera-manager-installer.bin
        
sudo ./cloudera-manager-installer.bin

sudo tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log

````


http://<server_host>:7180
Username: admin
Password: admin
