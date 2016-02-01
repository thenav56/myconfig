#!/bin/bash

rx1=$(cat ~/.config/i3blocks/rx)
tx1=$(cat ~/.config/i3blocks/tx)
rx2=$(cat /sys/class/net/wlp2s0/statistics/rx_bytes)
tx2=$(cat /sys/class/net/wlp2s0/statistics/tx_bytes)
echo "$rx2" > ~/.config/i3blocks/rx
echo "$tx2" > ~/.config/i3blocks/tx
upsd="($tx2-$tx1)/(5*1024)" #5 is for internal the script is runned
dnsd="($rx2-$rx1)/(5*1024)"
umag="KB/s"
dmag="KB/s"
if (( $upsd > 900 )) ; then
tx1=$(cat ~/.config/i3blocks/tx)
    upsd=$upsd/1024
    umag="MB/s"
fi
if (( $dnsd > 900 )) ; then
    dnsd=$dnsd/1024
    dmag="MB/s"
fi
echo "" $( bc <<< "scale = 2; $dnsd" ) "$dmag"  "" $( bc <<< "scale = 2; $upsd" ) "$umag" 
