pipeline {
  agent any
  stages {
    stage('DEV') {
      steps {
        git(url: 'https://github.com/DC-2017/DevOps.git', branch: 'master', changelog: true, credentialsId: '7db40ef5424f7edff7b6d3695caf0afc69c96a9c', poll: true)
        echo 'Create Docker Image Build'
      }
    }
    stage('TEST') {
      steps {
        echo 'Create TEST environment in AWS'
        echo 'Deploy latest Docker Build to TEST'
        echo 'Run Selenium Functional Tests in TEST'
        echo 'Run Jmeter Performance Tests in TEST'
      }
    }
    stage('STAGE') {
      steps {
        echo 'Create STAGE environment in AWS'
        echo 'Deploy latest Docker Build to STAGE'
        echo 'Run Selenium Functional Tests in STAGE'
        echo 'Run Jmeter Performance Tests in STAGE'
      }
    }
    stage('PROD') {
      steps {
        echo 'Create PROD environment in AWS'
        echo 'Deploy latest Docker Build to PROD'
        echo 'Run Selenium Functional Tests in PROD'
        echo 'Run Jmeter Performance Tests in PROD'
      }
    }
  }
}
