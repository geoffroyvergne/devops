# AWS CLI

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

## install
brew install awscli

aws --version
aws-cli/2.1.24 Python/3.7.4 Linux/4.14.133-113.105.amzn2.x86_64 botocore/2.0.0

aws-cli/2.1.26 Python/3.9.1 Darwin/19.6.0 source/x86_64 prompt/off

## configuration
aws configure
Default region name [eu-west-1]: 
Default output format [json]: 

cat ~/.aws/credentials
cat ~/.aws/config 

aws configure set
aws configure set region us-west-2 --profile integ

aws configure import

## profile

aws ec2 describe-instances --profile user1
export AWS_PROFILE=user1

## autocomplete
/usr/local/bin/aws_completer

## autoprompt
aws --cli-auto-prompt

## key
aws ec2 create-key-pair --key-name key-pair --query "KeyMaterial" --output text > key-pair.pem

# AMI
aws ec2 describe-images --owners self amazon

