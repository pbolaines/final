pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages {
        stage('Prep') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Git_Credentials', usernameVariable: 'MY_GITHUB_USERNAME', passwordVariable: 'MY_GITHUB_PASSWORD')]) {
                        git credentialsId: 'Git_Credentials', url: 'https://github.com/pbolaines/final.git', branch: 'main'
                    }
                }
                echo 'Building..'
            }
        }
        stage('Build') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                terraform init
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                echo 'Deploying terraform infrastructure'
                terraform destroy -auto-approve
                '''
            }
        }
    }
    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
                        
                
