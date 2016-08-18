#!/bin/bash

# A script to control media players
# works for both mpd and MPRIS players (vlc, spotify, audacious, ...)
# needs playerctl and mpdris2 (to connect to mpd)

# Song format
# Available vars: $title, $album, $artist
song_format="$title - $artist"

# Icons
icon_play=""
icon_pause=""

help() {
    cat << EOF
Usage: music.sh COMMAND

    Control media players.

Available commands:
    toggle        toggle between play/pause
    prev          skip to previous song
    next          skip to next song
    status        print current status

Options:
    -q, --quiet   suppress extra output
    -h, --help    show this help message and exit

To use this script's functionality in another, source with
    . music.sh --lib
EOF
}

toggle() {
    playerctl play-pause &> /dev/null
    if [[ "$?" != 0 ]] && [[ -z "$quiet" ]]; then
        echo "No media players available"
        exit 1
    fi
}

next-prev() {
    playerctl $1 &> /dev/null
    if [[ "$?" != 0 ]] && [[ -z "$quiet" ]]; then
        echo "No media players available"
        exit 1
    fi
}

get_info() {
    artist="$(playerctl metadata artist)"
    album="$(playerctl metadata album)"
    title="$(playerctl metadata title)"
    echo "$title - $artist"
}

get_status() {
    current="$(playerctl status)"
    if [[ "$?" != 0 ]] && [[ -z "$quiet" ]]; then
        current="No media players available"
    fi
    if [[ -z "$quiet" ]]; then
        echo "$current: $(get_info)"
    else
        if [[ "$current" == "Playing" ]]; then
            echo "$icon_play $(get_info)"
        elif [[ "$current" == "Paused" ]]; then
            echo "$icon_pause"
        fi
    fi
}

unknown() {
    if [[ -z "$quiet" ]]; then
        echo "Unknown $1"
    fi
    exit 1
}

main() {
    # Check for --help early
    case "$@" in
        *"-h"* | *"--help"*) help; exit;;
    esac

    # Library usage
    [[ "$1" == "--lib" ]] && return

    while [ "$1" ]; do
        case "$1" in

            # Commands
            toggle)             cmd="toggle";;
            prev|next)          cmd="next-prev $1";;
            status)             cmd="get_status";;

            # Options
            -q|--quiet)         quiet="true";;

            -*)                 unknown "option";;
            *)                  unknown "command";;
        esac
        shift
    done

    # Default to printing status if no command specified
    if [[ -z "$cmd" ]]; then
        get_status
        return
    else
        $cmd
    fi
}

main "$@"
