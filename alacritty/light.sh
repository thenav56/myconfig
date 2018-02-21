DEST='/home/navin/git/myconfig/alacritty'
cat $DEST/config.yml-template | sed 's\colors: [*]dark\colors: *light\' > $DEST/config.yml
