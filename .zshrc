# ─── Meta ───────────────────────────────────────────────────────
# Vaelix's Zsh Configuration
# Adapted for Fedora Asahi (M2 Mac)
# Based on ViegPhunt's config
# Ensure running interactively
[[ $- != *i* ]] && return

# ─── History ─────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory

# ─── Keybinds ────────────────────────────────────────────────────
bindkey -e

# ─── FZF ─────────────────────────────────────────────────────────
# Check if fzf is installed
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
    
    # FZF theme catppuccin
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#313244,label:#CDD6F4"
    export FZF_TAB_COLORS='fg:#CDD6F4,bg:#1E1E2E,hl:#F38BA8,min-height=5'
fi

# ─── Zinit ───────────────────────────────────────────────────────
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ─── Completion ──────────────────────────────────────────────────
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{A-Za-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=17

# Preview with eza and bat if available
if command -v eza &> /dev/null && command -v bat &> /dev/null; then
    zstyle ':fzf-tab:complete:*' fzf-preview '
    if [ -d "$realpath" ]; then
        eza --icons --tree --level=2 --color=always "$realpath"
    elif [ -f "$realpath" ]; then
        bat -n --color=always --line-range :500 "$realpath"
    fi
    '
fi

# ─── Aliases ─────────────────────────────────────────────────────
# Use eza if available, otherwise ls
if command -v eza &> /dev/null; then
    alias ls='eza --icons --color=always'
    alias ll='eza --icons --color=always -l'
    alias la='eza --icons --color=always -a'
    alias lla='eza --icons --color=always -la'
    alias lt='eza --icons --color=always -a --tree --level=1'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -A --color=auto'
    alias lla='ls -lAh --color=auto'
fi

alias grep='grep --color=always'
alias vim='nvim'

# Fedora-specific aliases
alias update='sudo dnf update'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias search='dnf search'

# Git aliases
if command -v lazygit &> /dev/null; then
    alias lzg='lazygit'
fi

if command -v lazydocker &> /dev/null; then
    alias lzd='lazydocker'
fi

# Fun aliases
if command -v cbonsai &> /dev/null; then
    alias cbonsai='cbonsai -l -i -w 1'
fi

# ─── Tools Init ──────────────────────────────────────────────────
# Setup bat (better than cat)
if command -v bat &> /dev/null; then
    export BAT_THEME="base16"
    alias bat='bat --paging=never'
fi

# Setup zoxide (better than cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Pokemon startup (if available)
if command -v pokemon-colorscripts &> /dev/null; then
    pokemon-colorscripts --no-title -s -r
fi

# Initialize Oh-My-Posh
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/viet.omp.json)"
else
    # Fallback prompt
    PROMPT='%F{magenta}%n%f@%F{blue}%m%f %F{yellow}%~%f %# '
fi

# Auto-start Sway on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec sway
fi
