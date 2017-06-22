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
        sh '''$(aws ecr get-login --region us-east-2)




aws ec2 run-instances --image-id ami-3883a55d --count 1 --instance-type t2.micro --key-name jenkins-keypair --security-group-ids sg-f515cd9c --subnet-id subnet-5f17f824 --region us-east-2'''
        echo 'Deploy latest Docker Build to TEST'
        sh '''#ssh -i /home/ec2-user/jenkins_keypair.pem ec2-user@13.59.159.158 docker stop '$(docker ps -q)'
#ssh -i /home/ec2-user/jenkins_keypair.pem ec2-user@13.59.159.158 docker run -d -p 80:80 -t 687517088689.dkr.ecr.us-east-2.amazonaws.com/jenkins-server-demo:latest
'''
      }
    }
  }
}