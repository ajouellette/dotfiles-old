#
# zsh prompt
#
setopt prompt_subst

# git prompt (using script provided with git)
# show * for unstaged changes, + for staged changes
export GIT_PS1_SHOWDIRTYSTATE=1
# show % for untracked files
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show difference from upstream
export GIT_PS1_SHOWUPSTREAM="auto"
# color symbols
export GIT_PS1_SHOWCOLORHINTS=1

# using precmd to increase speed
# wrap colors in %{ and %} to avoid text garbling
prompt() { __git_ps1 "%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})" "> " " %s " }
#export PS1='%B%(?..[%?] )%{$fg[yellow]%}%n%b%{$reset_color%} (%{$fg[green]%}%~%{$reset_color%})${vcs_info_msg_0_}> '

# spell correct prompt
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (ynae) "

