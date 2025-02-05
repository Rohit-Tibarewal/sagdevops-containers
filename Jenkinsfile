pipeline {
    agent any
   
    parameters {
		choice(
            name: 'targetEnvironment',
            choices: ['dev', 'test', 'qa', 'prod'],
            description: 'Select the deployment environment'
        )
        string(name: 'buildScenario', defaultValue: 'microservices-runtime', description: 'Asset type to be build and pushed - available options: "microservices-runtime", "universal-messaging"')
        string(name: 'sourceContainerRegistryCredentials', defaultValue: 'cred-rohit-dockerhub', description: 'Source container registry credentials') 

        string(name: 'sourceContainerRegistryHost', defaultValue: 'docker.io', description: 'Source registry host. Default points to docker store.') 
        string(name: 'sourceContainerRegistryOrg', defaultValue: 'rohittibarewal', description: 'Source registry organization. Default points to SoftwareAG organization at docker store.') 
        string(name: 'sourceImageName', defaultValue: 'wm_msr107adapter_usinginstaller', description: 'Source image name. Sample values from docker hub - "webmethods-microservicesruntime" and "universalmessaging-server". Check here fo all available in docker store https://hub.docker.com/search?q=softwareag&type=image&image_filter=store') 
        string(name: 'sourceImageTag', defaultValue: 'base', description: 'Source image tag. For available version check the Softwareag section at docker store.') 

        
        string(name: 'testContainerHost', defaultValue: 'localhost', description: 'Host where the test container will be exposed') 
        string(name: 'testContainerPort', defaultValue: '5555', description: 'Port under which the test container will be reachable - e.g. 5555 or 9000. If multiple parallel pipelines are being executed, define different ports to avoid conflict on the host system - e.g. 5556, 5557, 5558.')       
        
        string(name: 'targetContainerRegistryCredentials', defaultValue: 'cred-rohit-dockerhub', description: 'Target container registry credentials') 
        string(name: 'targetContainerRegistryHost', defaultValue: 'docker.io', description: 'Target container registry host') 
        string(name: 'targetContainerRegistryOrg', defaultValue: 'rohittibarewal', description: 'Target container registry organization') 
        string(name: 'targetImageName', defaultValue: 'wm_msr107adapter_solutionimage', description: 'Target image name. Small caps only.') 
        string(name: 'targetImageTag', defaultValue: 'latest', description: 'Target image tag. A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.') 
        booleanParam(name: 'runTests', defaultValue: false, description: 'Whether to run test stage')

        string(name: 'testProperties', defaultValue: ' -DtestISUsername=Administrator -DtestISPassword=manage', description: 'test properties. The default are covering the IS test case.')
		
        string(name: 'deploymentName', defaultValue: 'msr-withadapter', description: 'The Deployment name whose container needs to be updated') 
        string(name: 'targetContainerName', defaultValue: 'msr-withadapter-cn', description: 'The Container, inside given Deployment, whose image needs to be updated') 
		
		booleanParam(name: 'ignoreISCCRFailure', defaultValue: true, description: 'Whether to Ignore Code Review Failures')
    }
    environment {
       BUILD_SCENARIO="${params.buildScenario}"
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
	   ISCCR_HOME_DIR="${WORKSPACE}/containers/microservices-runtime/isccr"
	   ISCCR_LICENSE_FILE="${WORKSPACE}/containers/microservices-runtime/licenses/license.txt"
	   IGNORE_ISCCR_FAILURE="${params.ignoreISCCRFailure}"
	   ANT_HOME="${WORKSPACE}/lib/ant"
	   TARGET_ENVIRONMENT="${params.targetEnvironment}"	   
	}
    
    
    stages {
		stage('Set Environment') {
		  steps {
			echo "The Target Environment is ${TARGET_ENVIRONMENT}"
		  }
		 }
		stage('Build Solution Image') {
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
        stage('Run Intermediate Standalone Container') {
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
		
		stage('Code Review with ISCCR') {
            steps {
                script {
					def isAssetsDir = "${WORKSPACE}/containers/microservices-runtime/assets/Packages"
					try{
                      
					  sh '''
					   	cp ${ISCCR_LICENSE_FILE} ${ISCCR_HOME_DIR}/.
					   	chmod +x ${ISCCR_HOME_DIR}/CodeReview.sh
    					echo  "Temp Update the PATH and JAVA_HOME variable for ISCCR"
    					export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.342.b07-2.el8_6.x86_64/jre
    					export PATH=$JAVA_HOME/bin:$PATH
    					export isAssetsDir=$isAssetsDir
    					echo IS assets directory value is ${isAssetsDir}
    					cd ${ISCCR_HOME_DIR} && ./CodeReview.sh -Dcode.review.directory=${isAssetsDir} -Dcode.review.runmode=MULTI -Dcode.review.pkgprefix=Fibo,Dev -Dcode.review.folder-prefix=Fibo,Dev
    					'''
					  
					  // sh "cp ${ISCCR_LICENSE_FILE} ${ISCCR_HOME_DIR}/."
					  // sh "chmod +x ${ISCCR_HOME_DIR}/CodeReview.sh"
					  // sh "cd ${ISCCR_HOME_DIR} && ./CodeReview.sh -Dcode.review.directory=${isAssetsDir} -Dcode.review.runmode=MULTI -Dcode.review.pkgprefix=Fibo,Dev -Dcode.review.folder-prefix=Fibo,Dev"
                        
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
						sh "cp ${ISCCR_HOME_DIR}/MULTI__CodeReviewReport__html-multi.html ${WORKSPACE}/report/" 
						echo "ISCCR Report can be found at ${WORKSPACE}/report/MULTI__CodeReviewReport__html-multi.html"
					}
				}
            }
        }
		
        stage('Test using WmTestSuite') {
            when {
                expression {
                    return params.runTests
                }
            }
            steps {
                script {				
						echo "BUILD with ANT_HOME as ${env.ANT_HOME}" 
						sh "chmod +x -R ${env.ANT_HOME}/bin/antRun*"
						def testsDir = "./containers/microservices-runtime/assets/Tests"
						sh "ant -file build.xml test -DtestISHost=${testContainerHost} -DtestISPort=${testContainerPort} -DtestObject=${params.buildScenario} -DtestDir=${testsDir} -DtestContainerName=${TEST_CONTAINER_NAME} ${params.testProperties}" 
                }
                dir('./report') {
                    junit '*.xml'
                }
            }
        }
        stage('Cleanup Intermediate Standalone Container') {
            steps {
                script {
                  dir ('./containers') {                       
                       //sh "docker-compose stop ${params.buildScenario}"
                    }
                }
            }
        }
        stage("Push Image to Registry") {
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
					echo "Apply Config Map"
					kubectl create configmap msr-app-properties --from-file=${WORKSPACE}/containers/${BUILD_SCENARIO}/properties/${TARGET_ENVIRONMENT}/application.properties -o yaml --dry-run=client | kubectl replace -f -
                    echo  "Apply Rolling Update"
					minikube kubectl -- set image deployment/${DEPLOYMENT_NAME} ${CONTAINER_NAME}=${TARGET_REG_ORG}/${TARGET_REPO_NAME}:${TARGET_REPO_TAG}
					minikube kubectl -- rollout status deployment/${DEPLOYMENT_NAME} -w				
					'''
            }
        }
    }
}
