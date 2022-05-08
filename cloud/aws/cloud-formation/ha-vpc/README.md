# AWS couldformation High Available VPC 

https://itnext.io/high-available-vpc-architecture-in-cloudformation-2f4d8a86f4d2
https://github.com/lvthillo/aws-private-ha-app-setup

## create stack
aws cloudformation create-stack --stack-name ha-vpc --template-body file://template.yml --parameters file://parameters.json 

## test

### Load Balancer
http://alb-<id>.eu-west-1.elb.amazonaws.com/
http://alb-093740592126.eu-west-1.elb.amazonaws.com/

eu-west-1:093740592126

## SSH bastion
ssh-add -K ~/.ssh/key-pair.pem
ssh -A ec2-user@<host>
ssh -A ec2-user@18.203.233.192

## ssh http servers from bastion
ssh ec2-user@10.0.4.241
ssh ec2-user@10.0.3.174

/var/log/cloud-init-output.log

## debug stack
aws cloudformation describe-stack-events --stack-name ha-vpc

## delete stack
aws cloudformation delete-stack --stack-name ha-vpc
