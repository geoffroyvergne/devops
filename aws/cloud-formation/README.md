# aws cloud formation
https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-whatis-concepts.html

aws cloudformation help

## list
aws cloudformation list-stacks

## deploy
aws cloudformation deploy --template-file cloud-formation/ec2/simple/ec2-simple.yml --stack-name ec2-simple
aws cloudformation deploy --template-file cloud-formation/ec2/vpc/ec2-vpc.yml --stack-name ec2-vpc
aws cloudformation deploy --template-file cloud-formation/web-server/web-server.yml --stack-name web-server
aws cloudformation deploy --template-file cloud-formation/elb/elb.yml --stack-name elb
aws cloudformation deploy --template-file cloud-formation/elb/elb-v2.yml --stack-name elb-v2

# update
aws cloudformation update-stack --template-file cloud-formation/elb/elb-v2.yml --stack-name elb-v2

## debug deploy
aws cloudformation describe-stack-events --stack-name ec2-simple
aws cloudformation describe-stack-events --stack-name ec2-vpc
aws cloudformation describe-stack-events --stack-name web-server
aws cloudformation describe-stack-events --stack-name elb
aws cloudformation describe-stack-events --stack-name elb-v2

## delete stack
aws cloudformation delete-stack --stack-name ec2-simple
aws cloudformation delete-stack --stack-name ec2-vpc
aws cloudformation delete-stack --stack-name web-server
aws cloudformation delete-stack --stack-name elb
aws cloudformation delete-stack --stack-name elb-v2