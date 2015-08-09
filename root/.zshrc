#
# ~/.zshrc
#     zsh configuration file

# keybindings
bindkey -e
# searching history
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^F" edit-command-line

autoload -U compinit && compinit
autoload -U colors && colors
autoload -U select-word-style
select-word-style bash
autoload -U edit-command-line
zle -N edit-command-line

setopt auto_cd
setopt correct
setopt completealiases

# history
export HISTFILE=~/.zsh_hist
export HISTSIZE=10000
export SAVEHIST=10000

setopt share_history
setopt append_history

setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_no_functions
setopt hist_verify

zstyle :compinstall filename '~/.zshrc'


################
# prompt
################
export PS1="%B%(?..[%?] )%b%{$fg[red]%}%n%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})> "
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (ynae) "

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##############################
####  aliases    #############
##############################
alias zshrc="vim ~/.zshrc && source ~/.zshrc"

alias c='clear'
alias x='exit'

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lAF'

alias grep='grep --color=auto'

alias rm='rm -Iv --one-file-system'
alias cp='cp -i'
alias mv='mv -i'

####################################
# Display some important information
####################################
uname -a
uptime
who -a

