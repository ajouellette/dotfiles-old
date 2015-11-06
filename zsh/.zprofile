# zsh/.zprofile
#   read before .zshrc when login shell started

# start X on tty1, tty2, or tty3
# choose session type (simple display manager)

# cow quotes
fortune | cowthink -W 50

# source ~/.profile
emulate sh -c 'source ~/.profile'

if [[ -z "$DISPLAY" && $XDG_VTNR -le 3 ]]; then
    echo
    echo "          Choose Session:"
    echo "===================================="
    echo
    echo "  1) i3"
    echo "  2) XFCE"
    echo "  3) console"

    read session

    case $session in
        1)
            startx ~/.xinitrc i3;;
        2)
            startx ~/.xinitrc xfce;;
        *) ;;
    esac
fi

