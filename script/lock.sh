#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
pkill compton
i3lock  --image=/tmp/screen.png -ef  --pointer=default -f -e --inactivity-timeout=22
rm /tmp/screen.png
compton -b
