#!/bin/bash

touch /tmp/i3blocks-rx
touch /tmp/i3blocks-tx

rx1=$(sed '1q;d' /tmp/i3blocks-rx)
rx1_time=$(sed '2q;d' /tmp/i3blocks-rx)
tx1=$(sed '1q;d' /tmp/i3blocks-tx)

rx2=$(cat /sys/class/net/wlp2s0/statistics/rx_bytes)
tx2=$(cat /sys/class/net/wlp2s0/statistics/tx_bytes)

echo "$rx2" > /tmp/i3blocks-rx
echo "$(date +%s)" >> /tmp/i3blocks-rx
echo "$tx2" > /tmp/i3blocks-tx

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
RED='#ff6f69'
YELLOW='#ffeead'
DYELLOW='#ffcc5c'
NC='#96ceb4' # No Color
colordD=$NC
colordU=$NC

if (( $DFFTIME > 0 )) ; then
if (( $upsd > 1000*1024 )) ; then
    upsd="$upsd/(1024*1024)"
    umag="MB/s"
    colordU=$RED
elif (( $upsd > 1000 )) ; then
    upsd=$upsd/1024
    umag="KB/s"
    if [[ "$upsd"  -gt 100 ]]; then
        colordU=$DYELLOW
    else
        colordU=$YELLOW
    fi
fi

if (( $dnsd > 1000*1024 )) ; then
    dnsd="$dnsd/(1024*1024)"
    dmag="MB/s"
    colordD=$RED
elif (( $dnsd > 1000 )) ; then
    dnsd=$dnsd/1024
    dmag="KB/s"
    if [[ "$dnsd"  -gt 500 ]]; then
        colordD=$DYELLOW
    else
        colordD=$YELLOW
    fi
fi
else
    exit
fi

if [ $( bc <<< "scale = 2; $upsd" ) == "0"  ] && [ $( bc <<< "scale = 2; $dnsd" ) == "0"   ]  ; then
    if [ "$umag" == "B/s" ] && [ "$dmag" == "B/s" ]  ; then
        exit
    fi
fi

echo "<span color='$colordD'>" $( bc <<< "scale = 2; $dnsd" ) "$dmag</span>"  "<span color='$colordU'>" $( bc <<< "scale = 2; $upsd" ) "$umag</span>"
