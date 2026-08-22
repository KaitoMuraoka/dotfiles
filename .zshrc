export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

###=====================================================
### zsh の見た目を変更
###=====================================================
# Git 情報を取得する zsh 標準機能を読み込む
autoload -Uz vcs_info
precmd() { vcs_info }

# 表示フォーマット: [ブランチ名] + 末尾スペース
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr   '%F{yellow}' # ステージ済みの変更あり
zstyle ':vcs_info:git:*' unstagedstr '%F{red}' # 未ステージの変更あり
zstyle ':vcs_info:git:*' formats       '%c%ugit:[%b]%f ' # 変更がなし
zstyle ':vcs_info:git:*' actionformats '%F{green}%c%ugit:[%b|%a]%f ' # rebaseなどの変更

# PROMPT 内の変数を毎回展開する
setopt prompt_subst

PROMPT='%~ ${vcs_info_msg_0_}%# '


# tmux プラグインの自動起動設定（plugins より前に記述する必要がある）
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_AUTOCONNECT=false

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
  fzf-tab
)

export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# claude-code のバックグラウンドアップグレード（cask パッケージのため --cask が必要）
(brew upgrade claude-code &>/dev/null &)

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    source /Users/kaito.muraoka/.emacs.d/straight/repos/emacs-libvterm/etc/emacs-vterm-zsh.sh
fi

# zsh の補完機能を読み込み、コマンド補完を有効にする設定
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    autoload -Uz compinit
    compinit
fi

# cd したらすぐにlsしてくれる
chpwd(){
	if [[ $(pwd) != $HOME ]]; then;
    eza --icons --git
	fi
}

# ai agent alias
alias big_brother="claude"

# reload alias
alias reload="exec zsh"

# Aliases 
alias c='clear'
# Git
alias gs='git status'
alias gc='git config user.name;git config user.email'
alias allClean='git restore . && git restore --staged . && git clean -f .'

# act
alias act='act --container-architecture linux/amd64'

# NeoVim Alias
alias vim='nvim'
alias nd='nvim ~/dotfiles/'
alias nz='nvim ~/dotfiles/.zshrc && source ~/.zshrc'
alias ng='nvim ~/dotfiles/.gitconfig && source ~/.gitconfig'
alias nn='cd ~/.config/nvim && nvim .'

alias pathcheck='echo $PATH'

# freeze alias
alias freeze='freeze --show-line-numbers --window'

# 設定ファイル編集用（既存のものを整理）
alias ez="e ~/.zshrc && source ~/.zshrc"
alias ei="e ~/.emacs.d/init.el"

# Created by `pipx` on 2024-06-01 13:51:03
export PATH="$PATH:/Users/kaitomuraoka/.local/bin"

# emacs alias
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

# eza alias
alias ls="eza --icons --git"
alias la="eza -a --icons --git"
alias ll="eza -aahl --icons --git"
alias lt="eza -T -L 3 -a -I 'node_modules|.git|.cache' --icons"
alias lta="eza -T -a -I 'node_modules|.git|.cache' --color=always --icons | less -r"
alias l="clear && ls"

## go
export PATH="$PATH:$(go env GOPATH)/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# thefuck
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# Ctrl+j で中断ジョブを一覧から fzf で選んで fg する
fzf-fg() {
  local job
  job=$(jobs | fzf --height 40% --reverse --no-sort | grep -o '^\[[0-9]*\]' | tr -d '[]')
  [[ -n "$job" ]] && fg %"$job"
  zle reset-prompt
}
zle -N fzf-fg
bindkey '\ej' fzf-fg

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kaito.muraoka/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# デフォルトでは全コマンドに対してfzf-tabを無効化
zstyle ':fzf-tab:*' disabled-on any

# 例外として git checkout / git switch だけ有効化
zstyle ':fzf-tab:complete:git-checkout:*' disabled-on none
zstyle ':fzf-tab:complete:git-switch:*' disabled-on none

# gh の新しい表示利用
export GH_EXPERIMENTAL_PROMPTER=1
export GITHUB_TOKEN="$(gh auth token)"
