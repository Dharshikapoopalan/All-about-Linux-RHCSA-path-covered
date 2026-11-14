#!/bin/bash

TO="aieraversion@gmail.com"
HOST=$(hostname)
DATE=$(date)

REPORT=$(cat <<EOF
CENTOS VIRTUAL MACHINE HEALTH CHECK

Hostname: $HOST
Date: $DATE

--------------------------------
SYSTEM UPTIME
--------------------------------
$(uptime)

--------------------------------
CPU USAGE
--------------------------------
$(top -bn1 | grep "Cpu(s)")

--------------------------------
MEMORY USAGE
--------------------------------
$(free -h)

--------------------------------
DISK USAGE
--------------------------------
$(df -h)

--------------------------------
RUNNING PROCESSES
--------------------------------
$(ps -e --no-headers | wc -l) processes running

--------------------------------
HEALTH CHECK COMPLETED
--------------------------------
EOF
)

echo "$REPORT" | mail -s "CentOS Daily Health Check - $HOST" "$TO"
