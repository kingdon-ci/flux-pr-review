// these values are configured on a per-project basis:
dockerRepoHost = 'docker.io'
dockerRepoUser = 'kingdonb' // (this User must match the value in jenkinsDockerSecret)
dockerRepoProj = 'flux-pr-review'

// these refer to a Jenkins secret (by secret "id"), can be in Jenkins global scope:
jenkinsDockerSecret = 'docker-registry-admin'
// jenkinsSshSecret    = 'jenkins-ssh'

// blank values that are filled in by pipeline steps below:
gitCommit = ''
imageTag = ''

pipeline {
  agent {
    kubernetes { yamlFile "jenkins/docker-pod.yaml" }
  }
  stages {
    // Build a Docker image and keep it locally for now
    stage('Build') {
      steps {
        container('docker') {
          withCredentials([
              [$class: 'UsernamePasswordMultiBinding',
              credentialsId: jenkinsDockerSecret,
              usernameVariable: 'DOCKER_REPO_USER',
              passwordVariable: 'DOCKER_REPO_PASSWORD']
          ]) {
            script {
              gitCommit = env.GIT_COMMIT.substring(0,8)
              imageTag = sh (script: "./jenkins/image-tag.sh", returnStdout: true)
            }
            sh """\
            #!/bin/sh
            export DOCKER_REPO_USER DOCKER_REPO_PASSWORD
            export DOCKER_REPO_HOST="${dockerRepoHost}"
            export DOCKER_REPO_PROJ="${dockerRepoProj}"
            export GIT_COMMIT="${gitCommit}"
            ./jenkins/docker-build.sh
            """.stripIndent()
          }
        }
      }
    }
    stage('Dev') {
      parallel {
        stage('Push') {
          steps {
            withCredentials([[$class: 'UsernamePasswordMultiBinding',
              credentialsId: jenkinsDockerSecret,
              usernameVariable: 'DOCKER_REPO_USER',
              passwordVariable: 'DOCKER_REPO_PASSWORD']]) {
              container('docker') {
                sh """\
                #!/bin/sh
                export DOCKER_REPO_USER DOCKER_REPO_PASSWORD
                export DOCKER_REPO_HOST="${dockerRepoHost}"
                export DOCKER_REPO_PROJ="${dockerRepoProj}"
                export GIT_COMMIT="${gitCommit}"
                ./jenkins/docker-push.sh
                """.stripIndent()
              }
            }
          }
        }
        stage('Test') {
          agent {
            kubernetes {
              yaml """\
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: test
                    image: ${dockerRepoHost}/${dockerRepoUser}/${dockerRepoProj}:jenkins_${gitCommit}
                    imagePullPolicy: Never
                    securityContext:
                      runAsUser: 1000
                    env:
                    - name: GITHUB_TOKEN
                      valueFrom:
                        secretKeyRef:
                          name: github-discussions
                          key: github-token
                    command:
                    - cat
                    resources:
                      requests:
                        memory: 256Mi
                        cpu: 50m
                      limits:
                        memory: 1Gi
                        cpu: 1200m
                    tty: true
                """.stripIndent()
            }
          }
          options { skipDefaultCheckout(true) }
          steps {
            // In jenkins-specific test image which has been set up for Jenkins
            // to run with user 1000, NB. this is a hard requirement of Jenkins,
            // (this is not a requirement of docker or rvm-docker-support)
            container('test') {
              sh (script: "cd /home/rvm/app && ./jenkins/rake-ci.sh")
            }
          }
        }
      }
    }
    stage('Push Tag') {
      steps {
        container('docker') {
          withCredentials([[$class: 'UsernamePasswordMultiBinding',
            credentialsId: jenkinsDockerSecret,
            usernameVariable: 'DOCKER_REPO_USER',
            passwordVariable: 'DOCKER_REPO_PASSWORD']]) {
            sh """\
            #!/bin/sh
            export DOCKER_REPO_USER DOCKER_REPO_PASSWORD
            export DOCKER_REPO_HOST="${dockerRepoHost}"
            export DOCKER_REPO_PROJ="${dockerRepoProj}"
            export GIT_COMMIT="${gitCommit}"
            export GIT_TAG_REF="${imageTag}"
            ./jenkins/docker-hub-tag-success-push.sh
            """.stripIndent()
          }
        }
      }
    }
  }
}
