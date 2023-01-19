pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: "50"))
        timestamps ()
    }
    parameters {
        string(name: 'DEPLOY_PROD', defaultValue: 'YES')
    }
    environment {
        EC2_HOST_UAT = "172.31.23.36"
        EC2_HOST_PRODUCTION_WEB1 = "172.31.13.52"
        EC2_HOST_PRODUCTION_WEB2 = "172.31.12.55"
    }
    stages {
        stage("Zip cubes") {
            steps {
                sh '''
                    zip -r cubes.zip bin/ models/ logs/
                '''
            }
        }
        stage("Deploy To UAT") {
            when {
                branch "master"
            }
            steps {
                deploy("${EC2_HOST_UAT}")
            }
        }
        stage("Approval of deploy to Production") {
            when {
                branch "release"
            }
            steps {
                script {
                    try {
                        timeout (time: 15, unit: "MINUTES") {
                            input message: "Do you want to proceed for Production deployment?"
                        }
                    }
                    catch (error) {
                        if ("${error}".startsWith("org.jenkinsci.plugins.workflow.steps.FlowInterruptedException")) {
                            currentBuild.result = "SUCCESS" // Build was aborted
                        }
                        env.DEPLOY_PROD = "NO"
                    }
                }
            }
        }
        stage("Deploy To Production") {
            when {
                allOf {
                    branch "release"
                    environment name: "DEPLOY_PROD", value: "YES"
                }
            }
            steps {
                deploy("${EC2_HOST_PRODUCTION_WEB1}")
                deploy("${EC2_HOST_PRODUCTION_WEB2}")
            }
        }
    }
}

def deploy(ec2_host) {
    withEnv(["EC2_HOST=${ec2_host}"]) {
        sh '''
            echo "deploy cube service"
            scp cubes.zip ubuntu@${EC2_HOST}:~/artifacts/
            ssh -tt -o StrictHostKeyChecking=no ubuntu@${EC2_HOST} << EOF
echo "backup last cubes.zip"
sudo cp /app/cubes/cubes.zip /app/cubes/cubes_backup.zip

echo "replace cubes.zip"
sudo rm -rf /app/cubes/cubes.zip
sudo cp /home/ubuntu/artifacts/cubes.zip /app/cubes/cubes.zip

echo "stop cube"
sudo su middleware
/app/cubes/bin/stop.sh &
sleep 5

echo "unzip cubes.zip"
unzip -o /app/cubes/cubes.zip -d /app/cubes/

echo "start cube"
/app/cubes/bin/start.sh &
sleep 5
exit

ps -ef | grep cube
exit
        EOF'''
    }
}
