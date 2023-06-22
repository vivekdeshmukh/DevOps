pipeline {
    
	agent any

	tools {
        maven "MAVEN3"
        jdk "OracleJDK8"
    }
	
    environment {
        registry = "vivekdeshmukh/devops_01"
        registryCredential = 'dockerhub'
    }
	
    stages {
        stage('BUILD'){
            steps {
                sh 'mvn clean install -DskipTests'
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
                sh 'docker build -t devops_01:latest .' 
          }
        }

        stage('Upload Image'){
          steps {
                sh 'echo "DOCKER_ACCESS_TOKEN" | docker login -u "USER_NAME" --password-stdin'
                sh 'docker tag devops_01:latest vivekdeshmukh/devops_01:latest'
                sh 'docker push vivekdeshmukh/devops_01:latest'
            }
          }
        }

        stage('Run Docker Container') {
            steps {
                sh "docker run -d -p 8082:8080 vivekdeshmukh/devops_01"
            }
        }
    }

}
