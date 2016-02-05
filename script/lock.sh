#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#file="/sys/class/backlight/radeon_bl0/brightness"
#old_brightness=$(cat "$file")
#brightnessCon 10
i3lock  --image=/tmp/screen.png --pointer=default -f -e --inactivity-timeout=22
rm /tmp/screen.png
#brightnessCon $old_brightness
