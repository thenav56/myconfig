#!/bin/bash

#rx1=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
rx1=$(cat ~/.config/i3blocks/rx)
#rx2=$(cat /sys/class/net/enp4s0/statistics/rx_bytes)
rx2=$(cat /sys/class/net/wlp2s0/statistics/rx_bytes)
tx1=$(cat ~/.config/i3blocks/tx)
tx2=$(cat /sys/class/net/wlp2s0/statistics/tx_bytes)
echo "$rx2" > ~/.config/i3blocks/rx
echo "$tx2" > ~/.config/i3blocks/tx
echo "" $( bc <<< "scale = 2; ($rx2-$rx1)/1024" ) "KB/s"  "" $( bc <<< "scale = 2; ($tx2-$tx1)/1024" ) "KB/s"
