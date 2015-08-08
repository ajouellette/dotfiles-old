#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# merge in Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# disable caps lock key
xmodmap ~/.Xmodmap &

# enable screen blanking
xset +dpms &
xset dpms 0 0 240 &

# i3 is default
session=${1:-i3}

case $session in 
    bspwm) 
        source ~/.xbspwm.sh;;
    i3)
        source ~/.xi3.sh;;
    xfce)
        startxfce4;;
    # no known session, try to run command
    *)
        exec $1;;
esac

