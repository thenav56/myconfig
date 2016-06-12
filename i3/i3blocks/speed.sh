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
RED='#FF0000'
YELLOW='#FFFF00'
NC='#DFFFFF' # No Color
colord=$NC

if (( $DFFTIME > 0 )) ; then
if (( $upsd > 1000*1024 )) ; then
    upsd="$upsd/(1024*1024)"
    umag="MB/s"
    colord=$RED
elif (( $upsd > 1000 )) ; then
    upsd=$upsd/1024
    umag="KB/s"
    colord=$YELLOW
fi
if (( $dnsd > 1000*1024 )) ; then
    dnsd="$dnsd/(1024*1024)"
    dmag="MB/s"
    colord=$RED
elif (( $dnsd > 1000 )) ; then
    dnsd=$dnsd/1024
    dmag="KB/s"
    colord=$YELLOW
fi
else
    exit
fi

if [ $( bc <<< "scale = 2; $upsd" ) == "0"  ] && [ $( bc <<< "scale = 2; $dnsd" ) == "0"   ]  ; then
    if [ "$umag" == "B/s" ] && [ "$dmag" == "B/s" ]  ; then
        exit
    fi
fi

echo "" $( bc <<< "scale = 2; $dnsd" ) "$dmag"  "" $( bc <<< "scale = 2; $upsd" ) "$umag"
echo "nope"
echo "$colord\n";
