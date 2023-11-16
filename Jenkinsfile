pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Prep') {
            steps {
                script {
                    // Use withCredentials block to securely provide GitHub credentials
                    withCredentials([usernamePassword(credentialsId: 'GitHub_Credentials', usernameVariable: 'MY_GITHUB_USERNAME', passwordVariable: 'MY_GITHUB_PASSWORD')]) {
                        // Clone the Git repository
                        git credentialsId: 'GitHub_Credentials', url: 'https://github.com/pbolaines/final.git', branch: 'main'
                    }
                }
                echo 'Building..'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Initialize Terraform
                    try {
                        sh 'terraform init'
                    } catch (Exception e) {
                        // Handle terraform init failure
                        error "Terraform initialization failed: ${e.message}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Set AWS credentials for Terraform
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Deploy Terraform infrastructure
                        echo 'Deploying Terraform infrastructure'
                        try {
                            // Run Terraform apply and capture both standard output and standard error
                            def tfApplyOutput = sh(script: 'terraform apply -auto-approve', returnStdout: true, returnStatus: true)
                            
                            // Check the exit code of the Terraform apply command
                            if (tfApplyOutput != 0) {
                                // Handle non-zero exit code (failure)
                                error "Terraform deployment failed with exit code ${tfApplyOutput}"
                            }
                        } catch (Exception e) {
                            // Handle other exceptions
                            error "Terraform deployment failed: ${e.message}"
                        }
                    }
                }
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
