#!/bin/bash
# A script to control media players
# works for both mpd and MPRIS players (vlc, spotify, audacious, ...)
# needs mpc and playerctl

help() {
    echo "Usage: music.sh COMMAND"
    echo
    echo "Available commands:"
    echo "  toggle      toggle between play/pause"
    echo "  prev        skip to previous song"
    echo "  next        skip to next song"
}

toggle() {
    playerctl play-pause &> /dev/null
    status1="$?"
    mpc toggle &> /dev/null
    status2="$?"
    if [[ $status1 != 0 && $status2 != 0 ]]; then
        echo "Could not find any playing media players"
        exit 1
    fi
}

next-prev() {
    playerctl $1 &> /dev/null
    status1="$?"
    mpc $1 &> /dev/null
    status2="$?"
    if [[ $status1 != 0 && $status2 != 0 ]]; then
        echo "Could not find any playing media players"
        exit 1
    fi
}

case "$1" in
    toggle)             $1;;
    prev|next)          next-prev $1;;
    -h|--help)          help;;
    *)                  echo "Unknown command"
                        exit 1;;
esac
