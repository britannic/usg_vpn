#!/bin/bash
#
# File: wan-event-vpn-reset.sh
# Desc: Resets VPN after WAN transistion events and also reports them to the controller. This script should be configured under the
#       "load-balance group <GROUP_NAME> transition-script" config node. If the controller reporting
#       script is not found, logs to syslog

VERSION=1.0

# Set up the Vyatta environment
source /etc/bash_completion
complete -D -F _vyatta_op_default_expand
shopt -s expand_aliases


REPORT_SCRIPT=/usr/bin/mca-custom-alert.sh
NAME=wan-event
EVENT_STRING="EVT_GW_WANTransition"
IFACE=$2
STATE=$3
YES="/usr/bin/yes Y"

logger -t $NAME -- "[WAN Transition] $IFACE to state $STATE"
[ -f $REPORT_SCRIPT ] && $REPORT_SCRIPT -k event_string -v "$EVENT_STRING" -k iface -v "$IFACE" -k state -v "$STATE"

# Clear conntracking tables
${YES} | clear connection-tracking

# Restart the VPN processess
restart vpn 