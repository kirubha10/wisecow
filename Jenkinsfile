pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kirubha10/wisecow.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                 // Navigate to the workspace directory
                 dir('/var/lib/jenkins/workspace/wisecow') {
                     script {
                        withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                            sh "docker build -t kirubha2020/wisecow:version$BUILD_NUMBER Docker ."
                            }
                                 
                  }
                }
             }
        } 

        }

        
    }
}
