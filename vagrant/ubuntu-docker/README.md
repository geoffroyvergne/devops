# vagrant ubuntu docker

ansible-playbook -i inventory playbook.yml

vagrant provision

Save vm state
vagrant package --output /data/iso/vagrant-box/ubuntu-docker.box
vagrant box add --name kubernetes-ubuntu /data/iso/vagrant-box/ubuntu-docker.box

