pipeline {
    agent any
   
    parameters {
        string(name: 'buildScenario', defaultValue: 'microservices-runtime', description: 'Asset type to be build and pushed - available options: "microservices-runtime", "universal-messaging"')
        string(name: 'sourceContainerRegistryCredentials', defaultValue: 'cred-rohit-dockerhub', description: 'Source container registry credentials') 

        string(name: 'sourceContainerRegistryHost', defaultValue: 'docker.io', description: 'Source registry host. Default points to docker store.') 
        string(name: 'sourceContainerRegistryOrg', defaultValue: 'rohittibarewal', description: 'Source registry organization. Default points to SoftwareAG organization at docker store.') 
        string(name: 'sourceImageName', defaultValue: 'msr107centoswithvar', description: 'Source image name. Sample values from docker hub - "webmethods-microservicesruntime" and "universalmessaging-server". Check here fo all available in docker store https://hub.docker.com/search?q=softwareag&type=image&image_filter=store') 
        string(name: 'sourceImageTag', defaultValue: 'base', description: 'Source image tag. For available version check the Softwareag section at docker store.') 

        
        string(name: 'testContainerHost', defaultValue: 'localhost', description: 'Host where the test container will be exposed') 
        string(name: 'testContainerPort', defaultValue: '5555', description: 'Port under which the test container will be reachable - e.g. 5555 or 9000. If multiple parallel pipelines are being executed, define different ports to avoid conflict on the host system - e.g. 5556, 5557, 5558.')       
        
        string(name: 'targetContainerRegistryCredentials', defaultValue: 'cred-rohit-dockerhub', description: 'Target container registry credentials') 
        string(name: 'targetContainerRegistryHost', defaultValue: 'docker.io', description: 'Target container registry host') 
        string(name: 'targetContainerRegistryOrg', defaultValue: 'rohittibarewal', description: 'Target container registry organization') 
        string(name: 'targetImageName', defaultValue: 'msr107centoswithvar', description: 'Target image name. Small caps only.') 
        string(name: 'targetImageTag', defaultValue: 'latest', description: 'Target image tag. A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.') 
        booleanParam(name: 'runTests', defaultValue: false, description: 'Whether to run test stage')

        string(name: 'testProperties', defaultValue: ' -DtestISUsername=Administrator -DtestISPassword=manage', description: 'test properties. The default are covering the IS test case.')
		
        string(name: 'deploymentName', defaultValue: 'msr-demo', description: 'The Deployment name whose container needs to be updated') 
        string(name: 'targetContainerName', defaultValue: 'msr-demo-cn', description: 'The Container, inside given Deployment, whose image needs to be updated') 
		
		string(name: 'isccrHomeDir', defaultValue: "/tmp/isccr", description: 'Directory inside the Container, where ISCCR will be installed') 
		booleanParam(name: 'ignoreISCCRFailure', defaultValue: false, description: 'Whether to Ignore Code Review Failures')
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
	   DEPLOYMENT_NAME="${params.deploymentName}"
       CONTAINER_NAME="${params.targetContainerName}"
	   ISCCR_HOME_DIR="${params.isccrHomeDir}"
	   IGNORE_ISCCR_FAILURE="${params.ignoreISCCRFailure}"
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
		
		stage('CodeReview-ISCCR') {
            steps {
                script {
					def isAssetsDir = "${WORKSPACE}/containers/microservices-runtime/assets/Packages"
					try{
                       sh "docker exec -w ${ISCCR_HOME_DIR} ${TEST_CONTAINER_NAME} ${ISCCR_HOME_DIR}/CodeReview.sh -Dcode.review.directory=${isAssetsDir} -Dcode.review.runmode=MULTI -Dcode.review.pkgprefix=MediaApp,Fibo,Dev -Dcode.review.folder-prefix=MediaApp,Fibo,Dev"
                        
                    }
					catch(error){
                       if("true".equals(IGNORE_ISCCR_FAILURE)) { 
                            echo "Ignore ISCCR Error and Continue..."							
                         } else { 
                             currentBuild.result = 'FAILURE'
                             echo "ISCCR ERROR cannot be ignored. Exit with Failure!"
                             sh "exit 1" 
                         } 
                    }
					finally{
						echo "Copy ISCCR HTML Report"
						sh "mkdir -p ${WORKSPACE}/report/"
						sh "docker cp ${TEST_CONTAINER_NAME}:${ISCCR_HOME_DIR}/MULTI__CodeReviewReport__html-multi.html ${WORKSPACE}/report/"      
						echo "ISCCR Report can be found at ${WORKSPACE}/report/MULTI__CodeReviewReport__html-multi.html"
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
                      // sh "docker-compose stop ${params.buildScenario}"
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
		stage("Release") {
            steps {
					sh '''
					echo  "Update the PATH"
					export PATH=$PATH:/usr/local/bin:/usr/local/sbin
                    echo  "Apply Rolling Update"
					minikube kubectl -- set image deployment/${DEPLOYMENT_NAME} ${CONTAINER_NAME}=${TARGET_REG_ORG}/${TARGET_REPO_NAME}:${TARGET_REPO_TAG}
					minikube kubectl -- rollout status deployment/${DEPLOYMENT_NAME} -w					
					'''
            }
        }
    }
}
