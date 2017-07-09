pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('DEV') {
      steps {

       script {
          currentBuild.displayName = "#1.0.${BUILD_ID}"
        }

        echo 'Build Docker Image for the Application'
        sh '''echo "Build Docker Image of the Application"
$(aws ecr get-login --region us-east-2)
cd demo-app
docker build -t dc-demo-app-image .

echo "Tag the Image"
docker tag dc-demo-app-image:latest 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest


echo "Push the Image to AWS container repository"
docker push 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest

echo "Update DEV environment"
docker stop $(docker ps -q)
docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest



'''
        build(job: 'SeleniumTesting-DEV', wait: true)
        build 'JMeterTesting-DEV'
      }
    }
    stage('TEST') {
      steps {
        echo 'Create TEST environment in AWS'
        sh '''instanceID=$(aws ec2 describe-instance-status --instance-ids i-0c02f6e4791251ae4 --query 'InstanceStatuses[*].InstanceId' --region us-east-2 --output text | awk '{print $1}')
if [ "$instanceID" == "i-0c02f6e4791251ae4" ]; then
echo "Instance exists http://13.59.175.163"
else
aws cloudformation create-stack --stack-name dc-cicd-test --template-body https://raw.githubusercontent.com/DC-2017/DevOps/master/env/test/ec2-deploy.json
fi'''
        echo 'Deploy latest Docker Build to TEST'
        sh '''cd /home/ec2-user
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com $(aws ecr get-login --region us-east-2)
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker stop '$(docker ps -q)'
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker pull 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest'''
        build 'SeleniumTesting-TEST'
        build 'JMeterTesting-TEST'
      }
    }
    stage('STAGE') {
      steps {
        echo 'Create STAGE environment in AWS'
        sh '''instanceID=$(aws ec2 describe-instance-status --instance-ids i-071f32c84a83c25c3 --query 'InstanceStatuses[*].InstanceId' --region us-east-2 --output text | awk '{print $1}')
if [ "$instanceID" == "i-071f32c84a83c25c3" ]; then
echo "Instance exists http://13.59.159.158"
else
aws cloudformation create-stack --stack-name dc-cicd-stage --template-body https://raw.githubusercontent.com/DC-2017/DevOps/master/env/stage/ec2-deploy.json
fi'''
        echo 'Deploy latest Docker Build to STAGE'
        sh '''cd /home/ec2-user
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-159-158.us-east-2.compute.amazonaws.com $(aws ecr get-login --region us-east-2)
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-159-158.us-east-2.compute.amazonaws.com docker stop '$(docker ps -q)'
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-159-158.us-east-2.compute.amazonaws.com docker pull 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-159-158.us-east-2.compute.amazonaws.com docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest'''
        build 'SeleniumTesting-STAGE'
        build 'JMeterTesting-STAGE'
      }
    }

       stage("Go/No-Go?") {
            steps {
              script {
                 def userInput = input(
                 id: 'userInput', message: 'Approved for Production?'
                 )
              }
            }
        }

    stage('PROD') {
      steps {
        echo 'Create PROD environment in AWS'
        sh '''instanceID=$(aws ec2 describe-instance-status --instance-ids i-0db66a1affb72970f --query 'InstanceStatuses[*].InstanceId' --region us-east-2 --output text | awk '{print $1}')
if [ "$instanceID" == "i-0db66a1affb72970f" ]; then
echo "Instance exists http://13.59.140.240"
else
aws cloudformation create-stack --stack-name dc-cicd-stage --template-body https://raw.githubusercontent.com/DC-2017/DevOps/master/env/prod/ec2-deploy.json
fi'''
        echo 'Deploy latest Docker Build to PROD'
        sh '''cd /home/ec2-user
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-140-240.us-east-2.compute.amazonaws.com $(aws ecr get-login --region us-east-2)
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-140-240.us-east-2.compute.amazonaws.com docker stop '$(docker ps -q)'
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-140-240.us-east-2.compute.amazonaws.com docker pull 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-140-240.us-east-2.compute.amazonaws.com docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/dc-demo-app-image:latest'''
      }
    }
  }
}
