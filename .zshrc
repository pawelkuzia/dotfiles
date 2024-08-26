# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
setopt hist_find_no_dups

# Set NeoVim as default editor
export EDITOR="nvim"
# FZF Config
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
export FZF_DEFAULT_COMMAND=""
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --layout=reverse"
export FZF_CTRL_R_OPTS="--layout=reverse"

# Zinit set foilder and download
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zinit Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions 
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab



# Basic auto/tab complete:
autoload -U compinit && compinit
zinit cdreplay -q

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLOURS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

ZSH_AUTOSUGGESTIONS_USE_COMP=1
ZSH_AUTOSUGGESTIONS_SUGGESTIONS=1
ZSH_AUTOSUGGESTIONS_SUGGESTIONS_COMMANDS=1
ZSH_AUTOSUGGESTIONS_SUGGESTIONS_OPTIONS=2
ZSH_AUTOSUGGESTIONS_SUGGESTIONS_FILES=0

# Prompt
# eval "$(oh-my-posh --config ~/.config/ohmyposh/zen.toml init zsh)"
# eval "$(starship init zsh)"

# Binds
bindkey -e 
bindkey  "^[[3~"  delete-char
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias ls='ls --color -A'
alias clr=clear
alias update='yay && flatpak update && hyprpm update'
alias cat=bat
alias vim=nvim
alias vi=nvim

# Sources
source /usr/share/doc/find-the-command/ftc.zsh askfirst

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
