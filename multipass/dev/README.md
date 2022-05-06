# Multipass dev 

## Create VM
multipass launch --cloud-init - --disk 40G --mem 4G --cpus 4 --name dev <<EOF
packages:
    - curl
    - vim
    - build-essential
    - clang
    - cmake
    - git
runcmd:
- mkdir /home/ubuntu/dev
EOF

## Get IP
DEV_IP=$(multipass info dev | grep IPv4 | awk '{print $2}')
echo $DEV_IP

## Add ssh key
cat ~/.ssh/id_rsa.pub  | multipass exec dev -- tee -a .ssh/authorized_keys

ssh -l ubuntu -- $(multipass info dev | grep 'IPv4' | awk '{print $2}')
