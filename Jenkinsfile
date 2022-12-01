pipeline {
agent any;
  environment {
   NAME = "bmp-loginform-service"
    VERSION = "${env.BUILD_ID}"
    IMAGE = "${NAME}:${VERSION}"
  }
  stages {
    stage("code clone") {
      steps {
      git branch: 'main', url: 'https://github.com/mohammadaszadali/bmp-loginform-service.git'
      }
  }
    stage("Docker Build IMAGE") {
      steps {
        sh "docker build -t ${IMAGE} ."
      }
    }
    stage("Docker IMAGE Push to Nexus") {
      steps {
        withCredentials([string(credentialsId: 'nexus-docker', variable: 'nexus-pwd')]) {
          sh "docker login -u admin -p ${nexus-pwd} http://3.219.34.33:8082"
          sh "docker tag ${IMAGE} 3.219.34.33:8082/${IMAGE}"
          sh "docker push 3.219.34.33:8082/${IMAGE}"
      }
    }
}
  }
}
