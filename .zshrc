# History settings
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erease
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_ignore_dups


#zstyle :compinstall filename '/home/pawelkuzia/.zshrc'


# Zinit set foilder and download
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zinit Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions 
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab



# Basic auto/tab complete:
autoload -U compinit && compinit
zinit cdreplay -q


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLOURS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Prompt
eval "$(oh-my-posh --config ~/.config/ohmyposh/zen.toml init zsh)"
#eval "$(starship init zsh)"

# Binds
bindkey -e 
bindkey  "^[[3~"  delete-char
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Aliases
alias ls='ls --color'

# Sources
source $HOME/.config/spotify-player/login.zsh