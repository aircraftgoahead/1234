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

        // -e "USB_HUB_BUS="' + str(device_usb['bus_hub']) + ' \
        // -e "USB_HUB_DEVICE="' + str(device_usb['device_hub']) + ' \
        // -e "USB_HUB_PORT="' + str(device_usb['port']) + ' \
        // -e "FTDI_HUB_BUS="' + str(device_ftdi['bus_hub']) + ' \
        // -e "FTDI_HUB_DEVICE="' + str(device_ftdi['device_hub']) + ' \
        // -e "FTDI_HUB_PORT="' + str(device_ftdi['port']) + ' \
        // -e "HIL_HW="' + device_usb['HW'] + ' \
        // -e "JENKINS_SLAVE_ID="' + str(config['JENKINS_SLAVE_ID']) + ' \
        // -e "JENKINS_SLAVE_SECRET="' + config['JENKINS_SLAVE_SECRET'] + ' \
        // -e "JENKINS_MASTER_URL="' + config['JENKINS_MASTER_URL'] + ' \

        stage('Flash') {
            steps {
                parallel(
                    'Flashing (USB)': {
                        sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0 && sleep 2'
                        sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1 && sleep 2'
                        sh './Tools/px_uploader.py --port $USB_DEVICE --baud-flightstack 115200 --baud-bootloader 115200 ./build/px4fmu-v4_default/nuttx_px4fmu-v4_default.px4'
                        sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 0 && sleep 2'
                        sh '/hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1 && sleep 2'
                    },
                    'Monitoring (FTDI)': {
                        timeout(time: 60, unit: 'SECONDS') {
                            sh '/hub-ctrl -b $FTDI_HUB_BUS -d $FTDI_HUB_DEVICE -P $FTDI_HUB_PORT -p 0 && sleep 2'
                            sh '/hub-ctrl -b $FTDI_HUB_BUS -d $FTDI_HUB_DEVICE -P $FTDI_HUB_PORT -p 1 && sleep 2'
                            sh './Tools/HIL/watch_serial.py --device $FTDI_DEVICE --baudrate 57600'
                        }
                    }
                )   
            }
            
        }

        // stage('Reboot Devices') {
        //     steps {
                // sh './Tools/jmavsim_run.sh -q -d /dev/ttyACM0 -b 921600 -r 250'
        //     }
        // }
        // stage('Deploy') {
        //     when {
        //         expression {
        //             $BUILD_NAME == 'PX4 Firmware'
        //         }
        //     }
        //     steps {
        //         echo 'Deploying....'
        //     }
        // }
    }
}
