pipeline {
    agent { 
        label 'linux'
    }

    environment { 
        BUILD_NAME = 'PX4 Firmware'
    }

    stages {
        stage('Build') {
            steps {
                sh 'make posix'
                sh 'ant -buildfile ./Tools/jMAVSim/build.xml'
            }
        }
        stage('HIL') {
            steps {
                sh './Tools/jmavsim_run.sh -q -d /dev/ttyACM0 -b 921600 -r 250'
            }
        }
        stage('Deploy') {
            when {
                expression {
                    $BUILD_NAME == 'PX4 Firmware'
                }
            }
            steps {
                echo 'Deploying....'
            }
        }
    }
}
