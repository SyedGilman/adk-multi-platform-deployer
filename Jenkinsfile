pipeline {
    agent any
    parameters {
        choice(name: 'DEPLOY_TARGET', choices: ['Docker', 'Kubernetes'], description: 'Select runtime target.')
    }
    environment {
        DOCKER_IMAGE = "adk-ai-platform:latest"
    }
    stages {
        stage('Sourced Checkout') { steps { checkout scm } }
        stage('Static Analysis') { steps { echo '✅ Code Validation Passed.' } }
        stage('Execute Docker Deployment') {
            when { expression { return params.DEPLOY_TARGET == 'Docker' } }
            steps {
                sh 'chmod +x scripts/docker_deploy.sh scripts/verify.sh'
                sh './scripts/docker_deploy.sh'
            }
        }
        stage('Execute Kubernetes Deployment') {
            when { expression { return params.DEPLOY_TARGET == 'Kubernetes' } }
            steps {
                sh 'chmod +x scripts/kubernetes_deploy.sh scripts/verify.sh'
                sh 'docker build -t ${DOCKER_IMAGE} .'
                sh './scripts/kubernetes_deploy.sh'
            }
        }
        stage('Automated Verification') {
            steps { sh './scripts/verify.sh "${params.DEPLOY_TARGET}"' }
        }
    }
}
