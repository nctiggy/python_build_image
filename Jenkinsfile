podTemplate(yaml: '''
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
''')

{
  node(POD_LABEL) {
    checkout scmGit(
        branches: [[name: 'main']],
        userRemoteConfigs: [[url: 'https://github.com/nctiggy/python_build_image.git']]
        )
      container('alpine') {
        stage('get latest tag') {
          sh '''
            apk update
            apk add git
            git config --global --add safe.directory /home/jenkins/agent/workspace/python_build_image
          '''
          sh(returnStdout: true, script: "git tag --contains").trim()
        }
      }
      container('kaniko') {
        withCredentials([file(credentialsId: 'dockerConfig', variable: 'docker-config')]) {
          stage('Build and Push Docker Container') {
            sh """
              cp ${docker-config} /kaniko/.docker/config.json
              cat /kaniko/.docker/config.json
              ls -ltra
              /kaniko/executor --destination=nctiggy/python-build-image
            """
          }
        }
      }
    }
}
