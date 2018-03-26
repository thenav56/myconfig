#!/bin/bash

recents=/tmp/editinvim_recents.txt
touch $recents
function setclip {
  xclip -selection c
}

function getclip {
  xclip -selection clipboard -o
}

file=$(mktemp)
echo $file >> $recents
termite --role=scratchpad -e "vim $file" # replace with your favorite terminal

cat $file | setclip

xdotool key ctrl+v
