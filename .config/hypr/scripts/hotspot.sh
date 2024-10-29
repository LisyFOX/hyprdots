#!/bin/bash

INTERFACE_IN="wlp4s0"   # Your Wi-Fi interface
INTERFACE_OUT="enp3s0"  # Your Ethernet interface
HOTSPOT_NAME="lisyfox-hotspot"  # Connection name for the hotspot

function start_hotspot {
    echo "Enabling hotspot..."

    # Enable iptables rules for routing
    sudo iptables -A FORWARD -i $INTERFACE_IN -o $INTERFACE_OUT -j ACCEPT
    sudo iptables -A FORWARD -i $INTERFACE_OUT -o $INTERFACE_IN -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -t nat -A POSTROUTING -o $INTERFACE_OUT -j MASQUERADE

    # Start the hotspot
    nmcli con up "$HOTSPOT_NAME"

    echo "Hotspot enabled."
}

function stop_hotspot {
    echo "Disabling hotspot..."

    # Remove iptables rules for routing
    sudo iptables -D FORWARD -i $INTERFACE_IN -o $INTERFACE_OUT -j ACCEPT
    sudo iptables -D FORWARD -i $INTERFACE_OUT -o $INTERFACE_IN -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -t nat -D POSTROUTING -o $INTERFACE_OUT -j MASQUERADE

    # Stop the hotspot
    nmcli con down "$HOTSPOT_NAME"

    echo "Hotspot disabled."
}

case "$1" in
    start)
        start_hotspot
        ;;
    stop)
        stop_hotspot
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        ;;
esac
