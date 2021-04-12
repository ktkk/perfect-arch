# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Promt
PS1="[%n@%M %~]$ "

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
