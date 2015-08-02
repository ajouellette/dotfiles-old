# ~/.zprofile
#   read before .zshrc when login shell started 

# start X on tty1, tty2, or tty3
# choose session type (simple display manager)

if [[ -z "$DISPLAY" && $XDG_VTNR -le 3 ]]; then
    echo 
    echo "          Choose Session:"
    echo "===================================="
    echo 
    echo "  1) i3"
    echo "  2) XFCE"
    echo "  3) console"

    read session

    if [ "$session" -eq 2 ]; then
        startxfce4
    elif [ "$session" -eq 1 ]; then
        startx
    else

    fi
fi


