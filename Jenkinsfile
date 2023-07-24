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
                pwd
                PASSWD=`echo '$DOCKER_CREDS_USR:$DOCKER_CREDS_PSW' | tr -d '\n' | base64 -i -w 0`
                JSON=`printf '{"auths": {"docker.io": {"auth": "%s"}}}' "$PASSWD"`
                echo "$JSON"
                echo "$JSON" > /kaniko/.docker/config.json
                cat /kaniko/.docker/config.json
                /kaniko/executor --destination nctiggy/python-build-image:$GIT_BRANCH
            '''
          }
        }
      }
    }
}
