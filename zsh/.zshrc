#
# ~/.zshrc
#     zsh configuration file

# keybinds
# vi in the shell is too confusing
bindkey -e
# searching history
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^F" edit-command-line


autoload -U compinit && compinit
# use this for pre-made prompts
#autoload -U promptinit && promptinit
autoload -U colors && colors
# whitespace is not the only word delimeter
autoload -U select-word-style
select-word-style bash
# edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
# vcs info
#autoload -Uz vcs_info

# 'cd dir' = 'dir'
setopt auto_cd
# correct and complete commands
setopt correct
setopt completealiases

# history
export HISTFILE=~/.zsh_hist
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
# ignore duplicates and commands starting with space
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
# share history
setopt share_history
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
setopt noclobber
# the second time overrides
setopt hist_allow_clobber

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

################
# prompts
################
setopt prompt_subst
# git prompt (using script provided with git)
source ~/.git-prompt.sh
# show * for unstaged changes, + for staged changes
export GIT_PS1_SHOWDIRTYSTATE=1
# show % for untracked files
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show difference from upstream
export GIT_PS1_SHOWUPSTREAM="auto"
# color symbols
export GIT_PS1_SHOWCOLORHINTS=1
# using precmd to increase speed
precmd() { __git_ps1 "%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})" "> " " %s " }

# wrap colors in %{ and %} to avoid text garbling
#export PS1='%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})${vcs_info_msg_0_}> '
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (ynae) "

##########################
# syntax highlighting
##########################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# command not found hook (install pkgfile)
#source /usr/share/doc/pkgfile/command-not-found.zsh

##############################
####  aliases    #############
##############################
alias zshrc="$EDITOR ~/.zshrc && source ~/.zshrc"

if [ -f ~/.zsh_aliases ]; then 
	. ~/.zsh_aliases
fi

####################################### 
# run startup programs
#######################################
# set colors for linux console
if [ "$TERM" = "linux" ]; then
    /bin/echo -e "
    \e]P02d2d2d
    \e]P1f2777a
    \e]P299cc99
    \e]P3ffcc66
    \e]P46699cc
    \e]P5cc99cc
    \e]P666cccc
    \e]P7d3d0c8
    \e]P8747369
    \e]P9f2777a
    \e]PA99cc99
    \e]PBffcc66
    \e]PC6699cc
    \e]PDcc99cc
    \e]PE66cccc
    \e]PFf2f0ec
    "
    # get rid of artifacts
    clear
fi

# system info and logo
screenfetch -t

# clock in top-right corner
#while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &  

