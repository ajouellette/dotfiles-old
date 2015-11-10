#!/bin/bash

display_help() {
    echo "Usage: [re|un]stow.sh <package1> [<package2> <package3> ...]"
    echo "    stow.sh:   creates symlinks to dotfiles for specified programs"
    echo "    unstow.sh: removes symlinks"
    echo "    restow.sh: removes and then re-creates symlinks"
    echo
    echo "    Stow determines what directories the symlinks go in"
    echo "    by parsing the file \"index\""
}

main() {
    case "$1" in
        -h|--help) display_help; return 1;;
        "")        display_help; return 1;;
    esac
    case "$0" in
        *restow*) flag=--restow;;
        *unstow*) flag=--delete;;
        *stow*)   flag=--stow;;
        *)        echo "Error!"; return 1;;
    esac

    for package in $@; do
        if [ -d "$package" ]; then
            array=( `grep "^$package:" index` )

            if [ -z "$array" ]; then
                echo "Error: \"$package\" not found in index"
                return 1
            fi

            dir=${array[1]}
            eval "mkdir -p $dir"
            eval "stow --verbose=1 -t $dir $flag $package"
        else
            echo "Error: directory \"$package\" not found"
            return 1
        fi
    done
}


main "$@"

