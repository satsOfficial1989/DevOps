#!/bin/bash

$(aws ecr get-login --region us-east-2)
stack_name=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --region us-east-2 --query 'StackSummaries[*].StackName' --output text | awk -v N=$2 '{print $2}')
if [ "$stack_name" == "ECS" ]; then
   echo Cloudformation Stack exists
else
   aws cloudformation create-stack --stack-name ECS --region us-east-2 --capabilities CAPABILITY_NAMED_IAM --template-body https://github.com/degandham/DC-CICD-demo/blob/master/env/test/ECSdeploy.json
fi
