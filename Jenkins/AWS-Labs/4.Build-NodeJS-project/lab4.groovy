// Sample website

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/andylovecloud/simple-vue-webpack.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        // stage('Upload Artifacts') {
        //     steps {
        //         // Upload the artifact to S3
        //         sh 'aws s3 cp ${WORKSPACE}/target/dist/ s3://udemy-jenkins-andylab3/jenkins/${BUILD_ID}/ --recursive'
        //     }
        // }
    }
}