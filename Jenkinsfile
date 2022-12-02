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
   withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'dev-rancher', namespace: '', serverUrl: 'https://10.0.5.35:6443') {
        sh "kubectl delete -f dev-deploy.yml"	
        sh "kubectl apply -f dev-deploy.yml"	
  }
}
}
}
