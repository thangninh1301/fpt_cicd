pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "thang13199/server-${GIT_BRANCH.tokenize('/').pop()}"
//        DOCKERHUB_CREDENTIALS = credentials('docker-hub-account')
    }
    stages {
        stage("Build") {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            environment {
                DOCKER_TAG = "${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0, 7)}"
            }
            steps {
                sh '''
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ./app
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                    docker image ls | grep ${DOCKER_IMAGE}'''
                withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    sh 'echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin'
                }

                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker push ${DOCKER_IMAGE}:latest"
                //clean to save disk
                sh "docker image rm ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker image rm ${DOCKER_IMAGE}:latest"
                sh "echo ${GIT_BRANCH}"
            }
        }

        stage("Deploy Master Branch Tasks") {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            when { expression {env.GIT_BRANCH == 'origin/master'}}
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    ansiblePlaybook(
                            credentialsId: 'fsoft-ctc',
                            playbook: 'install-docker-install-docker-playbook.yml',
                            inventory: 'hosts',
                            become: 'yes',
                            extraVars: [
                                    DOCKER_HUB_USERNAME: "${DOCKER_HUB_USERNAME}",
                                    DOCKER_HUB_PASSWORD: "${DOCKER_HUB_PASSWORD}"
                            ]
                    )
                }
            }
        }

        stage("Deploy Develop Branch Tasks") {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            when { expression {env.GIT_BRANCH == 'origin/develop'}}
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    ansiblePlaybook(
                            credentialsId: 'fsoft-ctc',
                            playbook: 'develop/install-docker-install-docker-playbook.yml',
                            inventory: 'hosts',
                            become: 'yes',
                            extraVars: [
                                    DOCKER_HUB_USERNAME: "${DOCKER_HUB_USERNAME}",
                                    DOCKER_HUB_PASSWORD: "${DOCKER_HUB_PASSWORD}"
                            ]
                    )
                }
            }
        }
    }
}