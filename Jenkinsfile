pipeline {
    agent {
        docker {
            image 'golang:1.20'  // Specify the Go version
        }
    }

    environment {
        DOCKER_IMAGE = 'jackupsurya/go-k8s-app:v1'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/jackupsurya/go-k8s-app.git'
            }
        }

        stage('Build Go App') {
            steps {
                sh 'go version'  // Check if Go is installed
                sh 'go mod tidy'
                sh 'go build -o app'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        sh 'docker push ' + DOCKER_IMAGE
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-secret', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
