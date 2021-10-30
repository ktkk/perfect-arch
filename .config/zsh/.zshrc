# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# History
HISTSIZE=1000
SAVEHIST=1000

# Automatically cd in to directories
setopt autocd

# Disable error beebs
unsetopt beep

# Set vi mode
bindkey -v

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Alias autocompletion
setopt completealiases

# Git info
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{green}*%f'
zstyle ':vcs_info:*' stagedstr ' %F{yellow}+%f'
zstyle ':vcs_info:git:*' formats '%s(%F{red}%b%f%u%c)'
zstyle ':vcs_info:git:*' actionformats '%s(%F{red}%b%f|%a%u%c)'

# Promt
PS1='[%n@%M %~] ${vcs_info_msg_0_}
$ '
