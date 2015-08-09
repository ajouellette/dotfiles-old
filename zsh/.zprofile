# ~/.zprofile
#   read before .zshrc when login shell started 

# start X on tty1, tty2, or tty3
# choose session type (simple display manager)

if [[ -z "$DISPLAY" && $XDG_VTNR -le 3 ]]; then
    echo 
    echo "          Choose Session:"
    echo "===================================="
    echo 
    echo "  1) bspwm"
    echo "  2) i3"
    echo "  3) XFCE"
    echo "  4) console"

    read session

    case $session in 
        1)
            startx ~/.xinitrc bspwm;;
        2)
            startx ~/.xinitrc i3;;
        3)
            startx ~/.xinitrc xfce;;
        *)
    esac
fi


