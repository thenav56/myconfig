case $(pkill compton --signal 0 -c) in
 1) pkill compton ;;
 *) compton --no-dnd-shadow -i .8 --config ~/git/myconfig/compton/config --vsync opengl;;
esac
