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
  }
}