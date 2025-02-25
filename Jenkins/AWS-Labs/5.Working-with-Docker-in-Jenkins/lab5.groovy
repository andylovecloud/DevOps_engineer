pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/andylovecloud/nodejs-random-color.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t nodejs-random-color:ver-${BUILD_ID} .'
            }
        }
        stage('Upload image to ECR') {
            steps {
                sh 'aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 767397681234.dkr.ecr.eu-north-1.amazonaws.com'
                sh 'docker tag nodejs-random-color:ver-${BUILD_ID}  767397681234.dkr.ecr.eu-north-1.amazonaws.com/nodejs-random-color:ver-${BUILD_ID} '
                sh 'docker push 767397681234.dkr.ecr.eu-north-1.amazonaws.com/nodejs-random-color:ver-${BUILD_ID} '
            }
        }
    }
}