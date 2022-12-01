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
       withCredentials([string(credentialsId: 'nexus-docker', variable: 'nexus_login')]) {
          sh "docker login -u admin -p ${nexus_login} http://3.219.34.33:8082"
          sh "docker tag ${IMAGE} 3.219.34.33:8082/${IMAGE}"
          sh "docker push 3.219.34.33:8082/${IMAGE}"
      }
    }
}
stage("Deploy to k8s") {
    steps{
        sh "chmod 777 imageversion.sh"
        sh "./imageversion.sh ${IMAGE}"
    sshagent(['jenkins_login']) {
    sh "ssh -o StrictHostKeyChecking=no ubuntu@54.221.96.157 kubectl get pods -n dev-test | grep jenkins > jenkinspods"
    sh "ssh -o StrictHostKeyChecking=no ubuntu@54.221.96.157  "
}
  }
}
}
}
