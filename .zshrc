# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pawelkuzia/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Add this to ~/.bashrc (or your $SHELL equivalent)
export SPOTIFY_ID=a09d5f7acfa7414eaa5d3a8560ffe020 # client id
export SPOTIFY_SECRET=30c71fd33edb41d69b6d11ff8d3d7ba0 # client secret

eval "$(starship init zsh)"
bindkey  "^[[3~"  delete-char
# Load ; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/autojump/autojump.zsh 2>/dev/null
