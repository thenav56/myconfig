cat ~/.config/i3/config-template | sed 's\set $mod Mod1\set $mod Mod4\' > ~/.config/i3/config
i3-msg reload
setxkbmap -layout us
