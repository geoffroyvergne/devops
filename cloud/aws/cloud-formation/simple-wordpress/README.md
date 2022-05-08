# AWS cloudformation simple wordpress

## create stack
aws cloudformation create-stack --stack-name simple-wordpress --template-body file://template.yml --parameters file://parameters.json

## debug stack
aws cloudformation describe-stack-events --stack-name simple-wordpress

## delete stack
aws cloudformation delete-stack --stack-name simple-wordpress

