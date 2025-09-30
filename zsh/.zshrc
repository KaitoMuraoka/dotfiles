export PATH=/opt/homebrew/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
  xcode
)

source $ZSH/oh-my-zsh.sh

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

# emacs no-window
#alias emacs='emacs -nw'

# Emacs Alias
alias ez='emacs ~/dotfiles/.zshrc && source ~/.zshrc'
alias eg='emacs ~/dotfiles/.gitconfig && ssource ~/.gitconfig'

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
export PATH=$PATH:$HOME/go/bin

## node nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval "$(rbenv init -)" # bash の場合は /Users/kaito/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
