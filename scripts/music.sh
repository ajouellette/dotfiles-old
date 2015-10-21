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
    if [[ "$?" != 0 ]]; then
        mpc toggle &> /dev/null
        if [[ "$?" != 0 ]]; then
            echo "Could not find any playing media players"
            exit 1
        fi
    fi
}

next-prev() {
    playerctl $1 &> /dev/null
    if [[ "$?" != 0 ]]; then
        mpc $1 &> /dev/null
        if [[ "$?" != 0 ]]; then
            echo "Could not find any playing media players"
            exit 1
        fi
    fi
}

case "$1" in
    toggle)             $1;;
    prev|next)          next-prev $1;;
    -h|--help)          help;;
    *)                  echo "Unknown command"
                        exit 1;;
esac
