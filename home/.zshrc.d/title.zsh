case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
   preexec () { print -Pn "\e]0;${PWD/$HOME/\~}: $1\a" }
   ;;
esac
