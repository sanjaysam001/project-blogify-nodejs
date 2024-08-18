## Install Plugins in Jenkins
1. **NodeJS Plugin**:
   - This plugin provides Node.js support for Jenkins Pipeline.
   - It allows you to execute Node.js scripts and commands directly within your Jenkins Pipeline scripts.

2. **Pipeline Maven Integration**:
   - This plugin provides Maven support for Jenkins Pipeline.
   - It allows you to use Maven commands directly within your Jenkins Pipeline scripts.
   - To install, follow the same steps as above, but search for "Pipeline Maven Integration" instead.

3. **Config File Provider**:
   - This plugin allows you to define configuration files (e.g., properties, XML, JSON) centrally in Jenkins.
   - These configurations can then be referenced and used by your Jenkins jobs.
   - Install it using the same procedure as mentioned earlier.

4. **SonarQube Scanner**:
   - SonarQube is a code quality and security analysis tool.
   - This plugin integrates Jenkins with SonarQube by providing a scanner that analyzes code during builds.
   - You can install it from the Jenkins plugin manager as described above.

5. **Kubernetes CLI**:
   - This plugin allows Jenkins to interact with Kubernetes clusters using the Kubernetes command-line tool (`kubectl`).
   - It's useful for tasks like deploying applications to Kubernetes from Jenkins jobs.
   - Install it through the plugin manager.

6. **Kubernetes**:
   - This plugin integrates Jenkins with Kubernetes by allowing Jenkins agents to run as pods within a Kubernetes cluster.
   - It provides dynamic scaling and resource optimization capabilities for Jenkins builds.
   - Install it from the Jenkins plugin manager.

7. **Docker**:
   - This plugin allows Jenkins to interact with Docker, enabling Docker builds and integration with Docker registries.
   - You can use it to build Docker images, run Docker containers, and push/pull images from Docker registries.
   - Install it from the plugin manager.

8. **Docker Pipeline Step**:
   - This plugin extends Jenkins Pipeline with steps to build, publish, and run Docker containers as part of your Pipeline scripts.
   - It provides a convenient way to manage Docker containers directly from Jenkins Pipelines.
   - Install it through the plugin manager like the others.
9. **NPM Plugin**:

   - This plugin integrates NPM (Node Package Manager) into Jenkins.
   - It allows you to install, update, and manage Node.js packages directly within your Jenkins Pipeline scripts.   
10. **Pipeline: NodeJS Plugin**:

  - This plugin is essential for Node.js applications in Jenkins.
  - It enables the execution of Node.js scripts and commands within your Jenkins Pipeline, making it easier to build and test Node.js projects.

11. **Credentials Plugin**:

  - This plugin provides centralized management of credentials in Jenkins.
  - It allows you to securely store and retrieve credentials like passwords, tokens, and keys within your Jenkins Pipeline scripts.

After installing these plugins, you may need to configure them according to your specific environment and requirements. This typically involves setting up credentials, configuring paths, and specifying options in Jenkins global configuration or individual job configurations. Each plugin usually comes with its own set of documentation to guide you through the configuration process.



## Pipeline 

```groovy

pipeline {
    agent any
    tools {
        nodejs 'nodejs'
    }
    
    environment {
       SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/sanjaysam001/blogify.git'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                sh 'npm install mongodb'
                sh 'npm install dotenv --save'
                sh 'npm install --save-dev webpack'
                sh 'npm install --save-dev webpack-cli'
                sh 'npm ci'
            }
        }
        
       stage('Run Tests') {
          steps {
               sh 'npm test'
            }
        }
        
        stage('File System Scan') {
            steps {
               sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                          -Dsonar.projectKey=blogify \
                          -Dsonar.projectName=blogify \
                          -Dsonar.sources=. \
                          -Dsonar.exclusions=**/node_modules/** \
                          -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info'''
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
                }
            }
        }
        
       
        
        stage('Build & Push Docker Image') {
            steps {
               script {
                   withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker build -t sanjaysam001/blogify:latest ."
                        sh "docker push sanjaysam001/blogify:latest"
                   }
               }
            }
        }
    }
}
```