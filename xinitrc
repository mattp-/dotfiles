#!/bin/bash

xrdb -merge ~/.Xdefaults

PATH=$HOME/local/bin:$PATH

#xset -b
#xsetroot -solid "#3F3F3F"
xsetroot -solid "#000000"
#feh --bg-scale dwm/bg.jpg

BASE_DIR=$(dirname $0)
XRC=$(readlink ~/.xinitrc)
GIT_DIR=$(dirname $XRC)

while true
do
	#xsetroot -name "$(date)"
	#sleep 1
    PROMPT=`$GIT_DIR/laptop.sh`;
	xsetroot -name "$PROMPT"
	sleep 60
done & # run in subshell

exec dwm & stalonetray
