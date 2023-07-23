pipeline {
    agent {
        kubernetes {
        yaml '''
          apiVersion: v1
          kind: Pod
          spec:
            containers:
            - name: kaniko
              image: gcr.io/kaniko-project/executor:latest
              command:
              - sleep
              args:
              - 99d
        '''
      }
    }
    environment {
      DOCKER_CONFIG = credentials("dockerConfig")
    }

    stages {
      stage('build the image') {
        steps {
          container('kaniko') {
            sh('cp $DOCKER_CONFIG /kaniko/.docker/config.json')
            sh("cat /kaniko/.docker/config.json")
            sh('/kaniko/executor --destination=nctiggy/python-build-image:$GIT_BRANCH')
          }
        }
      }
    }
}
