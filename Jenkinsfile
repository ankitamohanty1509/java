pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'ankitamohanty1509'  // Your DockerHub username
        DOCKER_HUB_PASSWORD = credentials('Ank150402ita@')  // Jenkins credentials for Docker Hub password
        KUBE_CONFIG = '/path/to/kubeconfig'  // Path to your Kubernetes config file (or use K8s plugin)
        IMAGE_NAME = 'helloworld-java'
        IMAGE_TAG = 'latest'
        REPO_URL = 'https://github.com/ankitamohanty1509/java.git'  // Your GitHub repo URL
    }

    stages {
        stage('Clone Git Repository') {
            steps {
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
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
                    sh '''
                    docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                    # Apply Kubernetes deployment
                    kubectl apply -f deployment.yaml
                    '''
                }
            }
        }

        stage('Scale Deployment') {
            steps {
                script {
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
