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
          sh(returnStdout: true, script: "apk update && apk add git")
          sh(returnStdout: true, script: "git tag --contains").trim()
        }
      }
      container('kaniko') {
        withCredentials([text(credentialsId: 'dockerhub_id', variable: 'dockerhub_id')]) {
          stage('Create dockerconfig') {
            sh '''
              sed -i 's/dockerhub-id/$dockerhub_id/g' /kaniko/.docker/config.json
            '''
          }
        }
        stage('Build and Push Docker Container') {
          sh '''
            ls -ltra
            /kaniko/executor --destination=nctiggy/pythonBuildImage:$TAG_NAME
          '''
        }
      }
    }
}
