# ZSH Simple Configuration - The Oak Project
# No powerline, no "beautyful" prompt and no "productive" colors
# Just efficient work

# Enabling and setting git info var to be used in prompt config.

autoload -Uz vcs_info
autoload -U colors && colors
autoload -Uz compinit

compinit

zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "%{$fg[blue]%}%b%{$reset_color%} "
precmd() {
    vcs_info
}

# Command history settings
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt NO_BEEP
setopt autocd

setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Enable substitution in the prompt.
setopt prompt_subst

# Config for the prompt. PS1 synonym.
prompt='%B%F{7}%~%f%b ${vcs_info_msg_0_}'
autoload -Uz compinit && compinit

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char

export TERM=xterm-256color

# Here comes customization: aliases, settings and other
# Just edit ~/.zsh.personal and extend configuration
[ -f ~/.zsh.personal ] && source ~/.zsh.personal
