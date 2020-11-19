
        def WORKDIR = "../.."
        def APP_NAME = "windfire-restaurants-ui"
        def DEV_PROJECT = "windfire"
        def STAGE_PROJECT = "windfire-stage"
        def PROD_PROJECT = "windfire-prod"
        def APP_GIT_URL = "https://github.com/robipozzi/windfire-restaurants-ui/"
        def DOCKER_HUB_CREDENTIALS = "hub-docker"
        def DOCKER_HUB_REPOSITORY = "robipozzi"
        //DOCKER_HUB_REPOSITORY = "${env.DOCKER_HUB_REPOSITORY}"
        def DOCKER_IMAGE = "${DOCKER_HUB_REPOSITORY}/${APP_NAME}"
        def DOCKER_TAG = "1.0"
        //DOCKER_TAG = "${env.BUILD_ID}"
        def PIPELINE_IMAGE = "robipozzi/cmdlines"
        def SLACK_CHANNEL = "windfire-restaurants"
        def dockerImage = ""

        // Pod Template
        def podLabel = "web"
        def cloud = "kubernetes"
        def registryCredsID = "registry-credentials-id"
        def serviceAccount = "jenkins"

        // Pod Environment Variables
        def namespace = "windfire"
        def registry = "docker.io"
        def imageName = "ibmcase/bluecompute-web"

        /*
        Optional Pod Environment Variables
        */
        //def helmHome = env.HELM_HOME ?: env.JENKINS_HOME + "/.helm"

    podTemplate(label: podLabel, cloud: cloud, serviceAccount: serviceAccount, envVars: [
            envVar(key: 'NAMESPACE', value: namespace),
            envVar(key: 'REGISTRY', value: registry),
            envVar(key: 'IMAGE_NAME', value: imageName)
        ],
        containers: [
            containerTemplate(name: 'podman', image: 'robipozzi/podman:1.0', ttyEnabled: true, command: 'cat', privileged: true)
    ]) {

        node(podLabel) {
            // Docker
            container(name:'podman', shell:'/bin/bash') {
                stage('Container image build') {
                    /*agent {
                        docker { image "${PIPELINE_IMAGE}" }
                    }*/
                    steps {
                        echo "### Running container image build stage ..."
                        echo "### Build " + DOCKER_IMAGE + ":" + DOCKER_TAG + " image ..."
                        script {
                            //sh 'podman build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                            sh """
                            #!/bin/bash
                            # Construct Image Name
                            echo podman build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                            """
                        }
                        echo "### Container image build stage done"
                    }
                }
                stage('Container image push') {
                    steps {
                        echo "### Running container image push stage ..."
                        echo "Pushing ${DOCKER_IMAGE}:${DOCKER_TAG} image to Docker Hub"
                        //echo podman login -u ${USERNAME} -p ${PASSWORD} ${REGISTRY} --tls-verify=false
                        sh """
                            #!/bin/bash
                            echo podman push ${DOCKER_IMAGE}:${DOCKER_TAG} --tls-verify=false
                            """
                        echo "### Container image push stage done"
                    }
                }
            }
        }
    }

    
    //agent any

    /*agent {
      node {
        label 'maven'
      }
    }*/

    /*stages {
        stage('Container image build') {
            steps {
                echo "### Running container image build stage ..."
                echo "### Build " + DOCKER_IMAGE + ":" + DOCKER_TAG + " image ..."
                script {
                    //sh 'podman build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                    sh """
                    #!/bin/bash
                    # Construct Image Name
                    echo podman build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
                echo "### Container image build stage done"
            }
        }
        stage('Container image push') {
            steps {
                echo "### Running container image push stage ..."
                echo "Pushing ${DOCKER_IMAGE}:${DOCKER_TAG} image to Docker Hub"
                //echo podman login -u ${USERNAME} -p ${PASSWORD} ${REGISTRY} --tls-verify=false
                sh """
                    #!/bin/bash
                    echo podman push ${DOCKER_IMAGE}:${DOCKER_TAG} --tls-verify=false
                    """
                echo "### Container image push stage done"
            }
        }
        stage('Deploy to DEV environment') {
            steps {
                echo '###### Deploy to DEV environment ######'
                script {
                    openshift.withCluster() {
                        openshift.withProject("$DEV_PROJECT") {
                            echo "Using project: ${openshift.project()}"
                            // If BuildConfig already exists, start a new build to update the application
                            if (openshift.selector("bc", APP_NAME).exists()) {
                                echo "BuildConfig " + APP_NAME + " exists, start new build to update app ..."
                                // Start new build (it corresponds to oc start-build <buildconfig>)
                                def bc = openshift.selector("bc", "${APP_NAME}")
                                bc.startBuild()
                                // If a Route does not exist, expose the Service and create the Route
                                if (!openshift.selector("route", APP_NAME).exists()) {
                                    echo "Route " + APP_NAME + " does not exist, exposing service ..." 
                                    def service = openshift.selector("service", APP_NAME)
                                    service.expose()
                                }
                            } 
                            // If BuildConfig does not exist, deploy a new application using an OpenShift Template
                            else{
                                echo "BuildConfig " + APP_NAME + " does not exist, creating app ..."
                                openshift.newApp('deployment/openshift/windfire-restaurants-ui-template.yaml')
                            }
                            def route = openshift.selector("route", APP_NAME)
                            echo "Test application with "
                            def result = route.describe()   
                        }
                    }
                }
            }
        }
    }*/