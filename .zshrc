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
    xcode
    tmux
    emacs
)

source $ZSH/oh-my-zsh.sh

# claude-code のバックグラウンドアップグレード（cask パッケージのため --cask が必要）
(brew upgrade claude-code &>/dev/null &)

# the fuck
eval "$(thefuck --alias)"

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

# note directory
alias worknote='cd ~/Desktop/note/work-note/ && nvim'
alias privatenote='cd ~/Desktop/note/private/ && nvim'

# VScode Alias
alias cz='code ~/.zshrc && source ~/.zshrc'
alias cg='code ~/.gitconfig && source ~/.gitconfig'

# Coteditor
alias cot="open -a /Applications/CotEditor.app"
# Fork (Git GUI App) alias
alias fork="open -a /Applications/Fork.app"

# Create SwiftCLI(SPM)
alias createSwiftCLI='swift package init  --type executable --name'

# freeze alias
alias freeze='freeze --show-line-numbers --window'

# --- Emacs Alias 決定版 ---

# 共通変数（パスが長いので変数にまとめます）
export EMACS_BIN="/Applications/Emacs.app/Contents/MacOS/Emacs"
export EMACS_CLIENT="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

# 1. 現在開いているEmacsで開く (GUI)
# すでに Emacs があればそれで開き、なければ新しく起動します
alias e="$EMACS_CLIENT -n -a ''"

# 2. 完全に「新しいウィンドウ（Frame）」としてEmacsを起動する (GUI)
# 既存のウィンドウとは別に、もう一つウィンドウを作りたい時用
alias en="$EMACS_CLIENT -n -c -a ''"

# 3. ターミナルの中でEmacsを開く (CUI)
# Vim (n) と同じように、ターミナル内で完結させたい時用
alias et="$EMACS_BIN -nw"

# 設定ファイル編集用（既存のものを整理）
alias ez="e ~/.zshrc && source ~/.zshrc"
alias ei="e ~/.emacs.d/init.el"

# Eza Alias (better ls)
# alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# alias version
alias vv='~/dotfiles/show-tool-version/ShowToolVersion.sh'

# alias move Directory
alias imwork='cd ~/caraquri/ && cd'
alias imdeveloper='cd ~/personalDevelop/'

# flutter aliases
alias flutter-create-mobile='flutter create --platforms=ios,android'

[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Created by `pipx` on 2024-06-01 13:51:03
export PATH="$PATH:/Users/kaitomuraoka/.local/bin"

# emacs alias
alias emacsinit="cd ~/.emacs.d/ && emacs -nw init.el && emacs --batch -f batch-byte-compile init.el"
# Emacsデーモンを起動する
alias emacs-start="/Applications/Emacs.app/Contents/MacOS/Emacs --daemon &>/dev/null &"
# Emacsデーモンをすべて終了する
alias emacs-stop="pkill -f 'emacs.*--daemon'"

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

## go
export PATH="$PATH:$(go env GOPATH)/bin"

## node nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval "$(rbenv init -)" # bash の場合は /Users/kaito/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"


alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"

# Emacs デーモンの自動起動（無効化中）
# if ! pgrep -f "emacs.*--daemon" > /dev/null 2>&1; then
#   /Applications/Emacs.app/Contents/MacOS/Emacs --daemon &>/dev/null &
# fi
