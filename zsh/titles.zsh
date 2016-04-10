# dynamic terminal titles

# Write some info to terminal title.
# This is seen when the shell prompts for input.
function title-precmd {
    case $TERM in
        *xterm* | rxvt*)
            print -Pn "\e]0;zsh (%~)\a";;
        *)
            return;;
    esac
}

# Write command and args to terminal title.
# This is seen while the shell waits for a command to complete.
function title-preexec {
    case $TERM in
        *xterm* | rxvt*)
            printf "\033]0;%s\a" "zsh: $1";;
        *)
            return;;
    esac
}

