#!/bin/sh
#
# z3bra - (c) wtfpl 2014
# Manage ALSA Master channel

test "$1" = "-h" && echo "usage `basename $0` [+|-|!]" && exit 0

level() {
    amixer get Master | sed -n 's/^.*\[\([0-9]\+%\).*$/\1/p' | uniq
}

state() {
    amixer get Master | sed -n 's/^.*\[\(o[nf]\+\)]$/\1/p' | uniq
}

update_bar() {
    if [ -n $(pgrep i3blocks) ]; then
        pkill -SIGRTMIN+10 i3blocks
    fi
}

test $# -eq 0 && echo "`level` `state`" && exit 0

case $1 in
    +)
        amixer set Master 3%+ >/dev/null
        update_bar;;
    -)
        amixer set Master 3%- >/dev/null
        update_bar;;
    !)
        amixer set Master toggle >/dev/null
        update_bar;;
    state|level)
        $1;;
    *)
        amixer set Master $1 >/dev/null
        update_bar;;
esac

