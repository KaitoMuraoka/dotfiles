# zshrc

## 読み込み順

zsh は上から順に評価されるため、ここで順番だけを管理する。
oh-my-zsh 用の変数は `oh-my-zsh.sh` より前に、補完は `compinit` の後に、PATH 変更は優先順位を崩さない並びで置く。

``` {.zsh file=build/zshrc}
<<oh-my-zsh-home>>
<<prompt>>
<<oh-my-zsh-plugins>>
<<editor>>
<<oh-my-zsh-load>>
<<emacs-vterm>>
<<completion>>
<<chpwd>>
<<abbr>>
<<aliases>>
<<path-pipx>>
<<path-go-rvm>>
<<fzf>>
<<ruby-openssl>>
<<thefuck>>
<<path-python>>
<<fzf-fg>>
<<path-local>>
<<rancher-desktop>>
<<zshrc-local>>
<<nodenv-rbenv>>
<<fzf-tab-config>>
<<gh>>
```

## oh-my-zsh の場所

oh-my-zsh のインストール先を指定する。テーマは使わず、プロンプトは後述の vcs_info で自作するため `ZSH_THEME` はコメントアウトしている。

``` {.zsh #oh-my-zsh-home}
export ZSH="$HOME/.oh-my-zsh"

```

## プロンプト

zsh 標準の vcs_info で Git のブランチ名を取得し、プロンプトに表示する。ステージ済みは黄、未ステージは赤、rebase などの操作中は緑で表示する。

``` {.zsh #prompt}
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
```

## oh-my-zsh のプラグイン

使うプラグインを列挙する。tmux プラグインの設定変数はプラグイン読み込み時に参照されるため、`plugins` より前に書く必要がある。

``` {.zsh #oh-my-zsh-plugins}
# tmux プラグインの自動起動設定（plugins より前に記述する必要がある）
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_AUTOCONNECT=false

plugins=(
    git
    web-search 
    fzf-tab 
    zsh-autosuggestions 
    zsh-syntax-highlighting
)
```

## エディタ

`EDITOR` に emacsclient を指定し、Git のコミットメッセージなどを Emacs の新しいフレームで編集する。

``` {.zsh #editor}
export EDITOR='nvim'
```

## oh-my-zsh の読み込み

ここまでに設定した変数とプラグイン一覧を使って oh-my-zsh を読み込む。これより後の設定は oh-my-zsh の設定を上書きできる。

``` {.zsh #oh-my-zsh-load}
source $ZSH/oh-my-zsh.sh
```

## Emacs vterm 連携

Emacs の vterm 内で起動したときだけ、vterm 用の連携スクリプトを読み込む。

``` {.zsh #emacs-vterm}
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    source $HOME/.emacs.d/straight/repos/emacs-libvterm/etc/emacs-vterm-zsh.sh
fi
```

## 補完

Homebrew で入れたコマンドの補完定義を `FPATH` に追加してから compinit を実行する。`FPATH` の追加は compinit より前でないと反映されない。

``` {.zsh #completion}
# zsh の補完機能を読み込み、コマンド補完を有効にする設定
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    autoload -Uz compinit
    compinit
fi
```

## cd 後の自動 ls

ディレクトリを移動したら eza で中身を表示する。ホームディレクトリでは量が多いので表示しない。
`cd` したらすぐに `ls` するのとほぼ一緒

``` {.zsh #chpwd}
chpwd(){
	if [[ -z $CLAUDECODE && $(pwd) != $HOME ]]; then;
    eza --icons --git
	fi
}
```

## 略語 (zsh-abbr)

zsh-abbr を読み込み、入力後に展開される略語を定義する。`-S` でセッション限定にし、`-q` で既存定義の警告を抑える。

``` {.zsh #abbr}
source "$(brew --prefix zsh-abbr)/share/zsh-abbr/zsh-abbr.zsh" # zsh-abbr
abbr -S -q big_brother="claude" # ai agent abbr -S -q
abbr -S -q reload="exec zsh" # reload abbr -S -q
# Aliases 
abbr -S -q c='clear'
```

Git 操作の略語。`allClean` は作業ツリーとステージの変更、未追跡ファイルをすべて捨てるので注意する。

``` {.zsh #abbr}
# Git
abbr -S -q gs='git status'
abbr -S -q gc='git config user.name;git config user.email'
abbr -S -q allClean='git restore . && git restore --staged . && git clean -f .'
```

act（GitHub Actions のローカル実行）を Apple Silicon でも動かすため、amd64 のコンテナを指定する。

``` {.zsh #abbr}
# act
abbr -S -q act='act --container-architecture linux/amd64'
```

Neovim で dotfiles や各種設定を開くための略語。

``` {.zsh #abbr}
# NeoVim Alias
abbr -S -q vim='nvim'
abbr -S -q nd='nvim ~/dotfiles/'
abbr -S -q nz='nvim ~/dotfiles/.zshrc && source ~/.zshrc'
abbr -S -q ng='nvim ~/dotfiles/.gitconfig && source ~/.gitconfig'
abbr -S -q nn='cd ~/.config/nvim && nvim .'

abbr -S -q pathcheck='echo $PATH'
```

freeze（コードの画像化）を行番号とウィンドウ枠付きで実行する。

``` {.zsh #abbr}
# freeze abbr -S -q
abbr -S -q freeze='freeze --show-line-numbers --window'
```

Emacs で設定ファイルを開くための略語。

``` {.zsh #abbr}
# 設定ファイル編集用（既存のものを整理）
abbr -S -q ez="e ~/.zshrc && source ~/.zshrc"
abbr -S -q ei="e ~/.emacs.d/init.el"
```

## エイリアス

Emacs 本体と emacsclient の呼び出し、Emacs デーモンの終了をまとめる。

``` {.zsh #aliases}
# emacs alias 
abbr -S -q emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias E="emacsclient"
alias emacs-kill="emacsclient -e '(kill-emacs)'"
```

ls 系を eza に置き換え、アイコンと Git 状態を表示する。`lt` / `lta` は node_modules などを除いたツリー表示。

``` {.zsh #aliases}
# eza 
alias ls="eza --icons --git"
alias la="eza -a --icons --git"
alias ll="eza -aahl --icons --git"
alias lt="eza -T -L 3 -a -I 'node_modules|.git|.cache' --icons"
alias lta="eza -T -a -I 'node_modules|.git|.cache' --color=always --icons | less -r"
alias l="clear && ls"
```

## PATH: pipx

pipx が入れたコマンドの置き場所を PATH の末尾に追加する。

``` {.zsh #path-pipx}
# Created by `pipx` on 2024-06-01 13:51:03
export PATH="$PATH:$HOME/.local/bin"
```

## PATH: Go と RVM

`go install` したバイナリと RVM を PATH の末尾に追加する。どちらも末尾追加なので、既存コマンドより優先されない。

``` {.zsh #path-go-rvm}
## go
export PATH="$PATH:$(go env GOPATH)/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
```

## fzf

fzf のキーバインドと補完の設定ファイルがあれば読み込む。

``` {.zsh #fzf}
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

## Ruby のビルド設定

Ruby をビルドするときに Homebrew の openssl@3 を使うよう指定する。

``` {.zsh #ruby-openssl}
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
```

## thefuck

直前に打ち間違えたコマンドを修正して実行する thefuck を、`f*ck` と `F*CK` で使えるようにする。

``` {.zsh #thefuck}
# thefuck
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)
```

## PATH: Python

ユーザー領域にインストールした Python 3.9 のパッケージのコマンドを PATH の先頭に追加する。

``` {.zsh #path-python}
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
```

## 中断ジョブの再開

中断中のジョブを fzf で選んで fg するウィジェットを定義し、`Alt+j`（`\ej`）に割り当てる。

``` {.zsh #fzf-fg}
# Ctrl+j で中断ジョブを一覧から fzf で選んで fg する
fzf-fg() {
  local job
  job=$(jobs | fzf --height 40% --reverse --no-sort | grep -o '^\[[0-9]*\]' | tr -d '[]')
  [[ -n "$job" ]] && fg %"$job"
  zle reset-prompt
}
zle -N fzf-fg
bindkey '\ej' fzf-fg
```

## PATH: 自作・ローカルのコマンド

`~/.local/bin`、Emacs 付属のコマンド、dotfiles の bin を PATH の先頭に追加する。後に書いたものほど優先される。

``` {.zsh #path-local}
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
```

## Rancher Desktop

Rancher Desktop が自動で追記する PATH 設定。マーカーの間は Rancher Desktop が管理するため手で編集しない。

``` {.zsh #rancher-desktop}
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
```

## マシン固有の設定

dotfiles で共有しない設定を `~/.zshrc.local` に置き、存在すれば読み込む。

``` {.zsh #zshrc-local}
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
```

## nodenv と rbenv

nodenv を PATH に追加してから初期化し、続けて rbenv も初期化する。プロジェクトごとの Node.js と Ruby のバージョンが使われるようになる。

``` {.zsh #nodenv-rbenv}
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
eval "$(rbenv init - zsh)"
```

## fzf-tab の有効範囲

fzf-tab は普段の補完では邪魔になるので全体では無効にし、ブランチを選ぶ git checkout と git switch のときだけ有効にする。

``` {.zsh #fzf-tab-config}
# デフォルトでは全コマンドに対してfzf-tabを無効化
zstyle ':fzf-tab:*' disabled-on any

# 例外として git checkout / git switch だけ有効化
zstyle ':fzf-tab:complete:git-checkout:*' disabled-on none
zstyle ':fzf-tab:complete:git-switch:*' disabled-on none
```

## GitHub CLI

gh の新しい対話プロンプトを有効にし、gh のログイン情報から `GITHUB_TOKEN` を設定して他のツールでも使えるようにする。

``` {.zsh #gh}
# gh の新しい表示利用
export GH_EXPERIMENTAL_PROMPTER=1
export GITHUB_TOKEN="$(gh auth token)"
```
