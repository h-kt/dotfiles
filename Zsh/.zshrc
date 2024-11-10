if [[ -f "/opt/homebrew/bin/brew" ]] then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
source <(fzf --zsh)

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# zinit ice depth"1"
# zinit light marlonrichert/zsh-autocomplete

zinit light Aloxaf/fzf-tab

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
zinit cdreplay -q

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/Dotfiles/Zsh/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -a -1 --color=always $realpath'

alias ls='eza --classify=always --colour=always --icons=always'
alias vim='nvim'
alias c='clear'

(cat ~/.cache/wal/sequences &)
eval "$(oh-my-posh init zsh --config ~/.local/share/omp/zen.toml)"
eval "$(zoxide init --cmd cd zsh)"
