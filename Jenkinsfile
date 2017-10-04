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
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0'
                sh 'sleep 2'
                sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1'
                sh 'sleep 2'
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
