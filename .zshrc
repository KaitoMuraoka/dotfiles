export PATH=/opt/homebrew/bin:$PATH

# oh-my-posh
eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config ~/oh-my-posh/mytheme.omp.json)"

# the fuck
eval "$(thefuck --alias)"

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

# Create SwiftCLI(SPM)
alias createSwiftCLI='swift package init  --type executable --name'

# freeze alias
alias freeze='freeze --show-line-numbers --window'

# emacs no-window
#alias emacs='emacs -nw'

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

## add zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## add zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
