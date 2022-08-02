pipeline {
 agent {
    node {
      label 'maven-jdk11'
    }
  }



    environment {
        REGISTRY = 'registry.cn-beijing.aliyuncs.com/pox'
        APP_NAME = 'chain-demo'
    }

  stages {
       stage('check out from git') {
               steps {
                 checkout([$class: 'GitSCM',
                 branches: [[name: 'test_data']],
                 extensions: [[$class: 'SubmoduleOption',
                 disableSubmodules: false,
                 parentCredentials: true,
                 recursiveSubmodules: true,
                 reference: '', trackingSubmodules: true]],
                 userRemoteConfigs: [[credentialsId: 'gitaccount', url: 'http://git.everylink.ai/layer1-chain/fetchd.git']]])
               }
       }
    stage('build & push') {
      steps {
        container('maven-jdk11') {
          withCredentials([usernamePassword(passwordVariable : 'DOCKER_PASSWORD' ,credentialsId : 'dockerhub' ,usernameVariable : 'DOCKER_USERNAME' ,)]) {
            sh 'echo "$DOCKER_PASSWORD" | docker login $REGISTRY -u "$DOCKER_USERNAME" --password-stdin'
            sh 'docker build -f Dockerfile -t $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER .'
            sh 'docker push $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER'
           }
         }
      }
    }
    stage('deploy to sandbox') {
      steps {
        kubernetesDeploy(enableConfigSubstitution: false, deleteResource: false, configs: 'deploy/sandbox/**', kubeconfigId: 'kubeconfig')
      }
    }

  }
}

