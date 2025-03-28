# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# nodebrew setup
export PATH=$HOME/.nodebrew/current/bin:$PATH

# fzm setup
export PATH="$PATH":"$HOME/.pub-cache/bin"

# rbenv path
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# fastlane path
export PATH=$PATH:/Users/kaitomuraoka/.rbenv/versions/3.3.0/lib/ruby/gems/3.3.0/gems/fastlane-2.220.0/fastlane/lib/fastlane.rb/fastlane/bin

#Java
#17
export JAVA_HOME=`/usr/libexec/java_home -v "21"`
PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:~/jdt-language-server-1.45.0-202501221836/bin

# fzf key bindings と fuzzy 補完
eval "$(fzf --zsh)"

# the fuck
eval "$(thefuck --alias)"

# cd したらすぐにlsしてくれる
chpwd(){
	if [[ $(pwd) != $HOME ]]; then;
    eza --icons --git
	fi
}

# Android Studio
export PATH=$PATH:/Applications/Android\ Studio.app/Contents/MacOS

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

## WezTerm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
export PATH="$HOME/.cargo/bin:$PATH"

## go
export PATH=$PATH:$HOME/go/bin

## zoxide
eval "$(zoxide init zsh)"
