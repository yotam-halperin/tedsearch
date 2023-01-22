pipeline {
    agent any
    
    tools {
        terraform 'tf'
    }

    stages {

        // clone the git repository
        stage('clone'){
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('terraform init'){
            steps{
                sh "terraform init"
            }
        }
        
        stage('check envs'){
            steps{
                script{
                    sh "bash destroyer.sh"
                }
            }
        }

    }

}
