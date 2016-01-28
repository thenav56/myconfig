#!/bin/bash

#rx1=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
rx1=$(cat ~/.config/i3blocks/rx)
rx2=$(cat /sys/class/net/wlan0/statistics/rx_bytes)

echo "$rx2" > ~/.config/i3blocks/rx
echo "↑" $( bc <<< "scale = 2; ($rx2-$rx1)/1024" ) "KB/s"

