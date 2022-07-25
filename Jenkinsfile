pipeline {
 agent {
    node {
      label 'rust'
    }
  }

//     parameters {
//         string(name:'TAG_NAME',defaultValue: '',description:'')
//     }

    environment {
        REGISTRY = 'registry.cn-beijing.aliyuncs.com/pox'
        APP_NAME = 'dtx-chain-test'
    }

  stages {
       stage('check out from git') {
               steps {
                 checkout([$class: 'GitSCM',
                 branches: [[name: 'test']],
                 extensions: [[$class: 'SubmoduleOption',
                 disableSubmodules: false,
                 parentCredentials: true,
                 recursiveSubmodules: true,
                 reference: '', trackingSubmodules: true]],
                 userRemoteConfigs: [[credentialsId: 'gitaccount', url: 'http://git.everylink.ai/layer1-chain/dtx-chain.git']]])
               }
       }
    stage('build & push') {
      steps {
        container('rust') {
//           sh 'cp cargoConfig /usr/local/cargo/config'
        //  sh 'cp cargoConfig ~/cargo/config'
//           sh 'git config --global url."https://github.powx.io/".insteadOf https://github.com/'
//           sh 'cargo update'
//          sh 'cargo build --release  --target-dir /data/cargo/cache/test/dtx_chain1'

//            sh 'mkdir release '
//            sh 'cp -R /data/cargo/cache/test/dtx_chain1/release/dtx-chain release/dtx-chain'
//            sh 'ls release -l'
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
        kubernetesDeploy(enableConfigSubstitution: true, deleteResource: false, configs: 'deploy/sandbox/**', kubeconfigId: 'kubeconfig')
      }
    }

  }
}

