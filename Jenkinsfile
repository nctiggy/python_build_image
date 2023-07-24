pipeline {
    agent {
        kubernetes {
        defaultContainer 'kaniko'
        yaml '''
          apiVersion: v1
          kind: Pod
          spec:
            containers:
            - name: kaniko
              image: gcr.io/kaniko-project/executor:debug
              imagePullPolicy: Always
              command:
              - sleep
              args:
              - 99d
              volumeMounts:
                - name: jenkins-docker-cfg
                  mountPath: /kaniko/.docker
            volumes:
            - name: jenkins-docker-cfg
              projected:
                sources:
                - secret:
                    name: regcred
                    items:
                      - key: .dockerconfigjson
                        path: config.json
        '''
      }
    }
    environment {
      DOCKER_CREDS = credentials("docker_creds")
    }

    stages {
      stage('build the image') {
        steps {
            sh("/kaniko/executor --destination nctiggy/python-build-image:$GIT_BRANCH")
          }
        }
      }
    }
}
