# .zshrc
#  zsh configuration file

# resume vim with ^Z
foreground-vi() {
    if [ -n "$(jobs | grep vi)" ]; then
        fg %?vi
    fi
}
zle -N foreground-vi

autoload -U compinit && compinit -d "$HOME/.cache/zsh/zcompdump"
# use this for pre-made prompts
#autoload -U promptinit && promptinit
autoload -U colors && colors
# whitespace is not the only word delimeter
autoload -U select-word-style && select-word-style bash
# edit command line in $EDITOR
autoload -U edit-command-line && zle -N edit-command-line

# 'cd dir' = 'dir'
setopt auto_cd
# correct and complete commands
setopt correct completealiases
# easier than find
setopt extendedglob

# history
export HISTFILE="$HOME/.cache/zsh/zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history share_history
# ignore duplicates and commands starting with space
setopt hist_ignore_dups hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
# ignore unnecessary whitespace
setopt hist_reduce_blanks
# expand before executing commands from history
setopt hist_verify
# remove history comand from history
setopt hist_no_store
# dont save function definitions
setopt hist_no_functions
# dont beep
setopt no_hist_beep

# dont erase files when using redirects
# use >| to override
setopt noclobber hist_allow_clobber

# extra files
source "$ZDOTDIR/style.zsh"
source "$ZDOTDIR/keybinds.zsh"

################
## Set path   ##
# this must be in .zshrc instead of .zshenv, due to the
# way that Arch Linux sets the path in /etc/profile
###################################################
# make path entries unique
typeset -U path

################
# prompts
################
setopt prompt_subst
# git prompt (using script provided with git)
source "$ZDOTDIR"/git.zsh
# show * for unstaged changes, + for staged changes
export GIT_PS1_SHOWDIRTYSTATE=1
# show % for untracked files
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show difference from upstream
export GIT_PS1_SHOWUPSTREAM="auto"
# color symbols
export GIT_PS1_SHOWCOLORHINTS=1
# using precmd to increase speed
prompt() { __git_ps1 "%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})" "> " " %s " }

# wrap colors in %{ and %} to avoid text garbling
#export PS1='%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})${vcs_info_msg_0_}> '
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (ynae) "

# dynamic titles

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

precmd() {
    prompt
    title-precmd
}
preexec() {
    title-preexec "$1"
}

##########################
# syntax highlighting
##########################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# command not found hook (install pkgfile)
#source /usr/share/doc/pkgfile/command-not-found.zsh

##############################
####  aliases    #############
##############################
alias zshrc="$EDITOR $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"

if [ -f "$ZDOTDIR"/aliases.zsh ]; then
	. "$ZDOTDIR"/aliases.zsh
fi

#######################################
# run startup programs
#######################################
# system info and logo
#screenfetch -t

# base16 256 terminal colors
#BASE16_SHELL=~/.config/base16-shell/base16-ocean.dark.sh
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# cow and quotes
#fortune | cowthink -f small -W 50

# GPG agent and SSH support
# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

