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
                 // Build the Docker image   
                             docker.build('wisecow-image', '-f Docker .')
                  }
                }
             }
        } 

         stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('kirubha2020/wisecow', 'docker-cred') {
                        docker.image("wisecow-image").push("latest")
                    }
                }
            }
        }

        
    }
}
