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
                    docker build -t wisecow-image -f /var/lib/jenkins/workspace/wisecow/Dockerfile .
                }
            }
        }

       
       
    }
}
