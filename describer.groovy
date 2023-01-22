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
                    env.result=sh(returnStdout: true, script: 'bash describer.sh')
                }
            }
        }

    }
    post {

        always {  
                mail bcc: '',
                            body: """<b>ENVIROMENTS</b>
                                <br> envs: <br> ${env.result}
                                <br>Project: ${env.JOB_NAME} 
                                <br>Build Number: ${env.BUILD_NUMBER} 
                                <br> URL de build: ${env.BUILD_URL}""",
                            cc: '',
                            charset: 'UTF-8',
                            from: '',
                            mimeType: 'text/html',
                            replyTo: '', 
                            subject: "calc enviroments",
                            to: sh(returnStdout: true, script: 'git log --format="%ae" | head -1').trim();  
        } 
    }
}
