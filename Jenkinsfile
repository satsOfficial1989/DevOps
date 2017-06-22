pipeline {
  agent any
  stages {
    stage('DEV') {
      steps {
        echo 'Build Docker Image for the Application'
        sh '''echo "Build Docker Image of the Application"
$(aws ecr get-login --region us-east-2)
docker build -t jenkins-server-demo .

echo "Tag the Image"
docker tag jenkins-server-demo:latest 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest


echo "Push the Image to AWS container repository"
docker push 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest

echo "Refresh DEV environment"
docker stop $(docker ps -q)
docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest



'''
      }
    }
    stage('TEST') {
      steps {
        echo 'Create TEST environment in AWS'
        sh '''instanceID=$(aws ec2 describe-instance-status --instance-ids i-0c02f6e4791251ae4 --query 'InstanceStatuses[*].InstanceId' --region us-east-2  --output text | awk '{print $1}')
if [ "$instanceID" == "i-0c02f6e4791251ae4" ]; then
echo "Instance exists http://13.59.175.163"
else
aws ec2 run-instances --image-id ami-3883a55d --count 1 --instance-type t2.micro --key-name jenkins-keypair --security-group-ids sg-f515cd9c --subnet-id subnet-5f17f824 --region us-east-2
fi'''
        echo 'Deploy latest Docker Build to TEST'
        sh '''cd /home/ec2-user
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com $(aws ecr get-login --region us-east-2)
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker stop '$(docker ps -q)'
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker pull 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest
ssh -i "jenkins-keypair.pem" ec2-user@ec2-13-59-175-163.us-east-2.compute.amazonaws.com docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest'''
      }
    }
  }
}