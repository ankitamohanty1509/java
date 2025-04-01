pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ankitamohanty1509/helloworld-java:latest' // Docker image name and tag
        REPO_URL = 'https://github.com/ankitamohanty1509/java.git' // Your GitHub repository URL
    }

    stages {
        stage('Clone Git Repository') {
            steps {
                // Clone the GitHub repository
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh '''
                    docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Use withCredentials to securely access Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: '2c202980-1a5f-4db1-a94c-634489c2efa6', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Docker login command using the credentials injected by withCredentials
                        sh '''
                        echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin
                        '''
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh '''
                    docker push ${DOCKER_IMAGE}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the app on Kubernetes using kubectl
                    sh '''
                    kubectl apply -f deployment.yaml
                    '''
                }
            }
        }

        stage('Scale Deployment') {
            steps {
                script {
                    // Scale the Kubernetes deployment to 3 replicas
                    sh '''
                    kubectl scale deployment helloworld-deployment --replicas=3
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'There was an error during the pipeline.'
        }
    }
}
