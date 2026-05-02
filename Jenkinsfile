pipeline {
    agent any

    stages {
        stage('IaC Security Scan') {
            steps {
                sh 'tfsec . --no-color'
            }
        }
    }
}
