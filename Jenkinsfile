pipeline {
    agent any
   
    parameters {
        string(name: 'buildScenario', defaultValue: 'microservices-runtime', description: 'Asset type to be build and pushed - available options: "microservices-runtime", "universal-messaging"')
        string(name: 'sourceContainerRegistryCredentials', defaultValue: '', description: 'Source container registry credentials') 

        string(name: 'sourceContainerRegistryHost', defaultValue: 'docker.io', description: 'Source registry host. Default points to docker store.') 
        string(name: 'sourceContainerRegistryOrg', defaultValue: 'store/softwareag', description: 'Source registry organization. Default points to SoftwareAG organization at docker store.') 
        string(name: 'sourceImageName', defaultValue: 'webmethods-microservicesruntime', description: 'Source image name. Sample values from docker hub - "webmethods-microservicesruntime" and "universalmessaging-server". Check here fo all available in docker store https://hub.docker.com/search?q=softwareag&type=image&image_filter=store') 
        string(name: 'sourceImageTag', defaultValue: '10.5', description: 'Source image tag. For available version check the Softwareag section at docker store.') 

        
        string(name: 'testContainerHost', defaultValue: 'localhost', description: 'Host where the test container will be exposed') 
        string(name: 'testContainerPort', defaultValue: '5555', description: 'Port under which the test container will be reachable - e.g. 5555 or 9000. If multiple parallel pipelines are being executed, define different ports to avoid conflict on the host system - e.g. 5556, 5557, 5558.')       
        
        string(name: 'targetContainerRegistryCredentials', defaultValue: '', description: 'Target container registry credentials') 
        string(name: 'targetContainerRegistryHost', defaultValue: '', description: 'Target container registry host') 
        string(name: 'targetContainerRegistryOrg', defaultValue: '', description: 'Target container registry organization') 
        string(name: 'targetImageName', defaultValue: '', description: 'Target image name. Small caps only.') 
        string(name: 'targetImageTag', defaultValue: '', description: 'Target image tag. A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.') 
        booleanParam(name: 'runTests', defaultValue: true, description: 'Whether to run test stage')

        string(name: 'testProperties', defaultValue: ' -DtestISUsername=Administrator -DtestISPassword=manage', description: 'test properties. The default are covering the IS test case.')
    }
    environment {
      REG_HOST="${params.sourceContainerRegistryHost}"
      REG_ORG="${params.sourceContainerRegistryOrg}"
      REPO_NAME="${params.sourceImageName}"
      REPO_TAG="${params.sourceImageTag}"
      TEST_CONTAINER_HOST="${params.testContainerHost}"
      TEST_CONTAINER_PORT="${params.testContainerPort}"
      TARGET_REG_HOST="${params.targetContainerRegistryHost}"
      TARGET_REG_ORG="${params.targetContainerRegistryOrg}"
      TARGET_REPO_NAME="${params.targetImageName}"
      TARGET_REPO_TAG="${params.targetImageTag}"
      TEST_CONTAINER_NAME="${BUILD_TAG}"  
    }
    
    
    stages {
        stage('Build') {
            steps {
                script {
                  dir ('./containers') {
                        docker.withRegistry("https://${params.sourceContainerRegistryHost}", "${params.sourceContainerRegistryCredentials}"){
                            sh "docker-compose config"
                            sh "docker-compose build ${params.buildScenario}"
                        }
                  }
                }
            }
        }
        stage('Run') {
            steps {
                script {
                  dir ('./containers') {
                        docker.withRegistry("https://${params.sourceContainerRegistryHost}", "${params.sourceContainerRegistryCredentials}"){
                            sh "docker-compose up -d --force-recreate --remove-orphans ${params.buildScenario}"
                        }
                    }
                }
            }
        }
        stage('Test') {
            when {
                expression {
                    return params.runTests
                }
            }
            steps {
                script {
                    def testsDir = "./containers/microservices-runtime/assets/Tests"
                    sh "ant -file build.xml test -DtestISHost=${testContainerHost} -DtestISPort=${testContainerPort} -DtestObject=${params.buildScenario} -DtestDir=${testsDir} -DtestContainerName=${TEST_CONTAINER_NAME} ${params.testProperties}" 
                }
                dir('./report') {
                    junit '*.xml'
                }
            }
        }
        stage('Stop') {
            steps {
                script {
                  dir ('./containers') {
                        sh "docker-compose stop ${params.buildScenario}"
                    }
                }
            }
        }
        stage("Push") {
            steps {
                script {
                    dir ('./containers') {
                        docker.withRegistry("https://${params.targetContainerRegistryHost}", "${params.targetContainerRegistryCredentials}"){
                            sh "docker-compose push ${params.buildScenario}"
                        }
                    }
                }
            }
        }
    }
}
