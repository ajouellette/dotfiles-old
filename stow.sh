#!/usr/bin/env bash

display_help() {
    cat << EOF
Usage: ./[re|un]stow.sh <package1> [<package2> <package3> ...]

    stow.sh:   creates symlinks to dotfiles for specified programs
    unstow.sh: removes symlinks
    restow.sh: removes and then re-creates symlinks

    Stow determines what directories the symlinks go in by parsing the file "index".
    The default directory is $XDG_CONFIG_HOME/package.
EOF
    exit 1
}

main() {
    case "$1" in
        -h|--help|"") display_help;;
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
                if [ -n "$XDG_CONFIG_HOME" ]; then
                    dir="$XDG_CONFIG_HOME/$package"
                else
                    dir="$HOME/.config/$package"
                fi
            else
                dir=${array[1]}
            fi

            eval "mkdir -p $dir"
            eval "stow --verbose=1 -t $dir $flag $package"
        else
            echo "Error: directory \"$package\" not found"
            return 1
        fi
    done
}

main "$@"
