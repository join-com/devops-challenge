pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "gauravchatrath/acceleration"
    }
    stages {
        stage('Build Docker Image for acceleration-a') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME , "./acceleration-a")
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
		stage('Push Docker Image acceleration-a') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}", "./acceleration-a")
                        app.push("latest")
                    }
                }
            }
        }
		stage('Build Docker Image for acceleration-dv') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME , "./acceleration-dv"))
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }	
        }
		stage('Push Docker Image acceleration-dv') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}", "./acceleration-dv")
                        app.push("latest")
                    }
                }
            }
        }
		stage('Build Docker Image for acceleration-calc') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME , "./acceleration-calc"))
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }	
        }
        stage('Push Docker Image acceleration-calc') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}", "./acceleration-calc")
                        app.push("latest")
                    }
                }
            }
        }
		stage('start minikube'){
			when {
                branch 'master'
            }
			steps {
				sh 'minikube start'
			}
		}
		stage('initialize helm'){
			when {
                branch 'master'
            }
			steps {
				sh 'helm init --upgrade'
			}
		}
		stage('instal helm'){
			when {
                branch 'master'
            }
			steps {
				sh 'helm install ./kuberneteshelm/ -n acceleration'
			}
		}
        stage('SmokeTest on acceleration-a') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sleep (time: 5)
                    def response = httpRequest (
                        url: "http://127.0.0.1:3002/",
                        timeout: 30
                    )
                    if (response.status != 200) {
                        error("Smoke test against acceleration-a deployment failed.")
                    }
                }
            }
        }
		stage('SmokeTest on acceleration-dv') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sleep (time: 5)
                    def response = httpRequest (
                        url: "http://127.0.0.1:3001/",
                        timeout: 30
                    )
                    if (response.status != 200) {
                        error("Smoke test against acceleration-dv deployment failed.")
                    }
                }
            }
        }
		stage('SmokeTest on acceleration-calc') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sleep (time: 5)
                    def response = httpRequest (
                        url: "http://127.0.0.1:3000/",
                        timeout: 30
                    )
                    if (response.status != 200) {
                        error("Smoke test against acceleration-calc deployment failed.")
                    }
                }
            }
        }
}
