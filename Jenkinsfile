pipeline {
    agent { 
        label 'PX4FMU_V4'
    }

    environment { 
        BUILD_NAME = 'PX4 Firmware'
    }

    stages {
        stage('Build') {
            steps {
                // sh 'make posix'
                // sh 'ant -buildfile ./Tools/jMAVSim/build.xml'
                sh 'make px4fmu-v4_default'
            }
        }
        stage('Flash') {
            steps {
                parallel(
                    'Flashing (USB)': {
                        timeout(time: 120, unit: 'SECONDS') {
                            sh './Tools/HIL/reboot_device.sh USB'
                            sh './Tools/px_uploader.py --port $USB_DEVICE --baud-flightstack 115200 --baud-bootloader 115200 ./build/px4fmu-v4_default/nuttx_px4fmu-v4_default.px4'
                            sh './Tools/HIL/reboot_device.sh USB'
                        }
                    },
                    'Monitoring (FTDI)': {
                        timeout(time: 120, unit: 'SECONDS') {
                            sh './Tools/HIL/reboot_device.sh FTDI'
                            sh './Tools/HIL/watch_serial.py --device $FTDI_DEVICE --baudrate 57600'
                        }
                    }
                )   
            }
        }
        stage('Test') {
            steps {
                timeout(time: 60, unit: 'SECONDS') {
                    sh './Tools/HIL/reboot_device.sh FTDI'
                    sh './Tools/HIL/reboot_device.sh USB'
                    sh './Tools/HIL/run_tests.py --device $FTDI_DEVICE'
                }
            }
        }
    }
}
