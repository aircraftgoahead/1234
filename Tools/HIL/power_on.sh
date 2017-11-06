#! /bin/bash

set -ev

if [[ $1 == "USB" ]]; then
    echo "Power on USB port"
    /hub-ctrl -b $USB_HUB_BUS -d $USB_HUB_DEVICE -P $USB_HUB_PORT -p 1
    echo "Wait 2 sec"
    sleep 2
elif [[ $1 == "FTDI" ]]; then
    echo "Power on USB port"
    /hub-ctrl -b $FTDI_HUB_BUS -d $FTDI_HUB_DEVICE -P $FTDI_HUB_PORT -p 1
    echo "Wait 2 sec"
    sleep 2
else
    echo "Usage: power_on.sh [USB|FTDI]"
    exit 1
fi
