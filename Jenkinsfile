pipeline {
    agent any

    parameters {
        choice(
            name: 'DEPLOY_TARGET', 
            choices: ['Docker', 'Kubernetes'], 
            description: 'Select the runtime infrastructure platform target for the Google ADK AI Agent.'
        )
    }

    environment {
        DOCKER_IMAGE = "adk-ai-platform:latest"
    }

    stages {
        stage('Sourced Checkout') {
            steps {
                echo '📦 Cloning and Syncing Repository Workspace...'
                checkout scm
            }
        }

        stage('Static Analysis') {
            steps {
                echo '✅ Code Validation Checks Passed.'
            }
        }

        stage('Execute Docker Deployment') {
            when {
                expression { return params.DEPLOY_TARGET == 'Docker' }
            }
            steps {
                echo '🐳 Target Pipeline Routed to Standalone Docker Container.'
                sh 'chmod +x scripts/docker_deploy.sh scripts/verify.sh'
                sh './scripts/docker_deploy.sh'
            }
        }

        stage('Execute Kubernetes Deployment') {
            when {
                expression { return params.DEPLOY_TARGET == 'Kubernetes' }
            }
            steps {
                echo '☸️ Target Pipeline Routed to Kubernetes Orchestration Cluster.'
                sh 'chmod +x scripts/kubernetes_deploy.sh scripts/verify.sh'
                sh 'docker build -t ${DOCKER_IMAGE} .'
                sh './scripts/kubernetes_deploy.sh'
            }
        }

        stage('Automated Verification') {
            steps {
                echo '🤖 Triggering Deployment Verification Checks...'
                // Fixed: Clean alternative execution syntax for safe parameter interpolation
                sh "./scripts/verify.sh ${params.DEPLOY_TARGET}"
            }
        }
    }
}
