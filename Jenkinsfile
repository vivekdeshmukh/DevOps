pipeline {
    
	agent any

	tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }
	
    // environment {
    //     registry = "vivekdeshmukh/devops_01"
    //     registryCredential = 'dockerhub'
    // }
	
    stages {
        stage('Fetch code') {
            steps {
               git branch: 'main', url: 'https://github.com/vivekdeshmukh/DevOps.git'
            }

	    }

        stage('BUILD'){
            steps {
                sh 'mvn install -DskipTests'
            }
            post {
	           success {
	              echo 'Now Archiving it...'
	              archiveArtifacts artifacts: '**/target/*.war'
	           }
	        }
        }

        stage('UNIT TEST'){
            steps {
                sh 'mvn test'
            }
        }

        stage('INTEGRATION TEST'){
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }

        stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('Build App Image') {
            steps {
                sh 'sudo docker build -t devops_01:latest .' 
            }
        }

        stage('Upload Image'){
            steps {
                sh 'sudo echo "dckr_pat_PqIs11ffvkn_GBRcdoJBW60Z3y4" | docker login -u "vivekdeshmukh" --password-stdin'
                sh 'sudo docker tag devops_01:latest vivekdeshmukh/devops_01:latest'
                sh 'sudo docker push vivekdeshmukh/devops_01:latest'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "sudo docker run -d -p 8082:8080 vivekdeshmukh/devops_01"
            }
        }
    }

}
