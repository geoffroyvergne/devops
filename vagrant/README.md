# Vagrant

sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart 

vagrant init

vagrant up

vagrant ssh


vagrant provision --provision-with install-ubuntu

Save vm state
vagrant package --output /data/iso/vagrant-box/freebsd-desktop.box
vagrant box add --name freebsd-desktop /data/iso/vagrant-box/freebsd-desktop.box

remove all boxes :
vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f