# .zshrc
#  zsh configuration file

# Modules {{{

autoload -U compinit && compinit -d "$HOME/.cache/zsh/zcompdump"
# use this for pre-made prompts
#autoload -U promptinit && promptinit
autoload -U colors && colors
# whitespace is not the only word delimeter
autoload -U select-word-style && select-word-style bash
# edit command line in $EDITOR
autoload -U edit-command-line && zle -N edit-command-line

autoload zmv

#}}}

# Settings {{{

setopt autocd
setopt extendedglob
setopt correct completealiases
setopt noclobber hist_allow_clobber
typeset -U path

# History {{{

export HISTFILE="$HOME/.cache/zsh/zhistory"
export HISTSIZE=10000; export SAVEHIST=10000

setopt append_history share_history
# ignore duplicates
setopt hist_ignore_dups hist_expire_dups_first hist_find_no_dups
# commands with whitespace
setopt hist_ignore_space hist_reduce_blanks
# expand before executing commands from history
setopt hist_verify
# don't save unnecessary stuff
setopt hist_no_store hist_no_functions
# dont beep
setopt no_hist_beep

#}}}

#}}}

# Load config files {{{

for config ($ZDOTDIR/*.zsh) source $config
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/doc/pkgfile/command-not-found.zsh
# base16 256 terminal colors
#BASE16_SHELL=~/.config/base16-shell/base16-ocean.dark.sh
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#}}}

# Hooks {{{

precmd() {
    prompt
    title-precmd
}
preexec() {
    title-preexec "$1"
}

#}}}

# Startup programs {{{

# GPG agent and SSH support
# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent.ssh"
fi

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# neovim socket (needs neovim-remote)
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"

# pip completion
#eval "`pip completion --zsh`"

# start tmux
if [ -z "$TMUX" ]; then
    tmux
fi

#}}}

# vim:foldmethod=marker:foldlevel=0
