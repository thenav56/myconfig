#!/bin/bash

rx1=$(sed '1q;d' ~/.config/i3blocks/rx)
rx1_time=$(sed '2q;d' ~/.config/i3blocks/rx)
tx1=$(sed '1q;d' ~/.config/i3blocks/tx)

rx2=$(cat /sys/class/net/wlp2s0/statistics/rx_bytes)
tx2=$(cat /sys/class/net/wlp2s0/statistics/tx_bytes)

echo "$rx2" > ~/.config/i3blocks/rx
echo "$(date +%s)" >> ~/.config/i3blocks/rx
echo "$tx2" > ~/.config/i3blocks/tx

CTIME=$(date +%s)
DFFTIME=$(($CTIME-$rx1_time))
if (( $DFFTIME > 0 )) ; then
upsd="($tx2-$tx1)/($DFFTIME)" #5 is for internal the script is runned
dnsd="($rx2-$rx1)/($DFFTIME)"
else
    exit
fi

umag="B/s"
dmag="B/s"

if (( $upsd > 1000*1024 )) ; then
    upsd="$upsd/(1024*1024)"
    umag="MB/s"
elif (( $upsd > 1000 )) ; then
    upsd=$upsd/1024
    umag="KB/s"
fi
if (( $dnsd > 1000*1024 )) ; then
    dnsd="$dnsd/(1024*1024)"
    dmag="MB/s"
elif (( $dnsd > 1000 )) ; then
    dnsd=$dnsd/1024
    dmag="KB/s"
fi

#if (( $upds < 1 ))  && (( $dnsd < 1 )) ; then
    #if (($umag = "B/s" && $dmag = "B/s")) ; then
        #exit
    #fi
#fi

    echo "" $( bc <<< "scale = 2; $dnsd" ) "$dmag"  "" $( bc <<< "scale = 2; $upsd" ) "$umag" 
