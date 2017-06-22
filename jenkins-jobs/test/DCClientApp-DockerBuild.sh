#!/bin/bash

$(aws ecr get-login --region us-east-2)
docker build -t containerapp-demo .
docker tag containerapp-demo:latest 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest
docker push 687517088689.dkr.ecr.us-east-2.amazonaws.com/containerapp-demo:latest
