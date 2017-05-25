case $(pkill compton --signal 0 -c) in
 1) pkill compton ;;
 *) compton -i .8 --config ~/git/myconfig/compton/config ;;
esac
