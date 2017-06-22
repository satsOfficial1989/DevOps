#!/bin/bash

$(aws ecr get-login --region us-east-2)

aws ecs register-task-definition --cli-input-json https://raw.githubusercontent.com/degandham/DC-CICD-demo/master/env/test/register_taskdefinition.json --region us-east-2

aws ecs run-task --cluster test --task-definition example_task_1 --count 1 --region us-east-2

if  aws ecs describe-services --cluster test --region us-east-2 --service app-test-service --query 'services[*].serviceName' --output text awk '{print $2}' = *app-test-service*
then
    aws ecs update-service --cluster test --service app-test-service --task-definition example_task_1 --region us-east-2
else
    aws ecs create-service --cli-input-json https://raw.githubusercontent.com/degandham/DC-CICD-demo/master/env/test/service.json --region us-east-2
fi
