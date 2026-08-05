export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

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
    xcode
)

source $ZSH/oh-my-zsh.sh

# claude-code のバックグラウンドアップグレード（cask パッケージのため --cask が必要）
(brew upgrade claude-code &>/dev/null &)

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    source /Users/kaito.muraoka/.emacs.d/straight/repos/emacs-libvterm/etc/emacs-vterm-zsh.sh
fi

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

# reload alias
alias reload="exec zsh"

# Aliases 
alias c='clear' # clearと入力するのがだるい🥱
# Git
alias gs='git status'
alias gc='git config user.name;git config user.email'
alias allClean='git restore . && git restore --staged . && git clean -f .'

# act
alias act='act --container-architecture linux/amd64'

# NeoVim Alias
alias n='nvim'
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
alias ei="eza --icons --git"
alias ea="eza -a --icons --git"
alias ee="eza -aahl --icons --git"
alias et="eza -T -L 3 -a -I 'node_modules|.git|.cache' --icons"
alias eta="eza -T -a -I 'node_modules|.git|.cache' --color=always --icons | less -r"
alias ls=ei
alias la=ea
alias ll=ee
alias lt=et
alias lta=eta
alias l="clear && ls"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/kaitomuraoka/.dart-cli-completion/zsh-config.zsh ]] && . /Users/kaitomuraoka/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Android / Java
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

## go
export PATH="$PATH:$(go env GOPATH)/bin"

## node nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval "$(rbenv init -)" # bash の場合は /Users/kaito/.bash_profile

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# thefuck
# https://github.com/nvbn/thefuck
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

# alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
# export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
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
export GH_EXPERIMENTAL_PROMPTER=1
