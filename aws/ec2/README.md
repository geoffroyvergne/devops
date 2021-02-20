# aws ec2

aws ec2 help

## list instances
aws ec2 describe-instances

## delete instances
aws ec2 terminate-instances --instance-ids i-5203422c

## list images
https://cloud-images.ubuntu.com/locator/ec2/
aws ec2 describe-images

https://wiki.centos.org/Cloud/AWS

## SSH
chmod 400 ~/.ssh/key-pair.pem
ssh -i "~/.ssh/key-pair.pem" <user>@<host>


