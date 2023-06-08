pipeline {
    agent any
    
    tools {
        maven 'Maven.3.8.7'
    }
    
    stages {
        stage("Git Checkout") {
            steps {
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/Git-LAnthony/Jenkins-k8s.git'
            }
        }
        
        stage("Maven Package") {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage("Sonarqube code scan") {
            steps {
                script{withSonarQubeEnv(credentialsId: 'sonarqube-token') {
                    sh "mvn clean package sonar:sonar"
                }
                }
            }
        }
      
        
        stage("Nexus artifact") {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'test-java-app', classifier: '', file: 'target/test-java-app.war', type: 'war']], credentialsId: 'admin', groupId: 'com.mt', nexusUrl: '54.236.49.57:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-mixed-artifactory', version: '1.1.1'
            }
        }
        
        stage("Docker Build") {
            steps {

                sh "docker build -t dockerlanthony/test-java-app:${BUILD_ID} ."
            }
        }
        
        stage("Docker Push") {
            steps {
                withCredentials([string(credentialsId: 'Dockerhubpws', variable: 'Dockerhubpwd')]) {
                    sh "docker login -u dockerlanthony -p ${Dockerhubpwd}"
                }
                sh "docker push dockerlanthony/webapp:${BUILD_ID}"
            }
        }
        
}
