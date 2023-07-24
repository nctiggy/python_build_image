pipeline {
    agent {
        kubernetes {
        yaml '''
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
        '''
      }
    }
    environment {
      DOCKER_CREDS = credentials("docker_creds")
    }

    stages {
      stage('build the image') {
        steps {
          container('kaniko') {
            sh '''
                PASSWD=`echo '$DOCKER_CREDS_USR:$DOCKER_CREDS_PSW' | tr -d '\n' | base64 -i -w 0`
                CONFIG="\{\n\"auths\": {\n\"docker.io\": {\n\"auth\": \"${PASSWD}\"\n}\n}\n}\n"
                printf "${CONFIG}" > /kaniko/.docker/config.json
                cat /kaniko/.docker/config.json
                /kaniko/executor --destination nctiggy/python-build-image:$GIT_BRANCH
            '''
          }
        }
      }
    }
}
