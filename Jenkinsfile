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
                             docker.build('kirubha2020/wisecow', '-f Docker .')
                  }
                }
             }
        } 

         stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/','docker-cred') {
                        docker.image("kirubha2020/wisecow").push("latest")
                    }
                }
            }
        }

        
    }
}
