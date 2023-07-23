pipeline {
    agent {
        kubernetes {
        yaml: '''
          apiVersion: v1
          kind: Pod
          spec:
            containers:
            - name: kaniko
              image: gcr.io/kaniko-project/executor:debug
              command:
              - sleep
              args:
              - 99d
            - name: alpine
              image: alpine
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
      stage('get latest tag') {
        steps {
          container('alpine') {
            sh '''
              apk update
              apk add git
              git config --global --add safe.directory /home/jenkins/agent/workspace/python_build_image
            '''
          }
        }
      }
      stage('build the image') {
        steps {
          container('kaniko') {
            sh('cp $DOCKER_CONFIG /kaniko/.docker/config.json')
            sh "/kaniko/executor --destination=nctiggy/python-build-image"
          }
        }
      }
}
