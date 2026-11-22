# gitconfig
バージョン管理システム Git の動作やユーザー情報を保存する設定ファイルです。通常はユーザーのホームディレクトリ（~/.gitconfig）に置かれ、そのユーザーが使っているすべてのGitリポジトリに共通する設定を管理します。

## 読み込み順

gitconfig は同じキーなら後に書いた値が優先される。delta のテーマを `include` で読み込んだ後に `[delta]` を書くことで、テーマの設定を上書きできるようにしている。

``` {.zsh file=build/gitconfig}
<<user>>
<<core>>
<<delta>>
<<merge>>
<<diff>>
<<alias>>
<<init>>
<<safe>>
<<lfs>>
```

## ユーザー情報

コミットに記録される名前とメールアドレス。メールアドレスは GitHub の noreply アドレスにして、個人のアドレスを公開しないようにしている。

``` {.zsh #user}
[user]
	name = KaitoMuraoka
	email = 70003919+KaitoMuraoka@users.noreply.github.com

```

## 基本設定

コミットメッセージなどの編集には nvim を使う。全リポジトリ共通で無視するファイルは `~/.gitignore_global` に書く。

``` {.zsh #core}
[core]
  editor = nvim
  excludesfile = ~/.gitignore_global

```

## delta

diff の表示を見やすくする delta をページャーに使う。`n` / `N` で差分間を移動でき、行番号も表示する。テーマは `delta/themes.gitconfig` から colibri を選んでいる。

``` {.zsh #delta}
# git delta config
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[include]
  path = ./delta/themes.gitconfig

[delta]
    navigate = true    # use n and N to move between diff sections
    line-numbers = true
    features = colibri

```

## マージ

コンフリクト表示に共通祖先も含める diff3 形式を使う。マージツールは macOS の FileMerge（opendiff）で、起動前の確認は省略する。

``` {.zsh #merge}
[merge]
    conflictstyle = diff3
	tool = opendiff

[mergetool "opendiff"]
	cmd = opendiff \"\" \"\" -ancestor \"\" -merge \"\"
[mergetool]
	prompt = false

```

## diff

移動しただけの行を別の色で表示する。`git difftool` では hunk を使う。

``` {.zsh #diff}
[diff]
    colorMoved = default
	tool = hunk

[difftool "hunk"]
	cmd = hunk diff

```

## alias

よく使う操作の短縮形。親ブロックでは `[alias]` の下に各エイリアスを並べる。

``` {.zsh #alias}
[alias]
<<alias-rebase-branch>>
<<alias-emptycommit>>
<<alias-logo>>
<<alias-delete-merged-branch>>
<<alias-copy-branch>>
<<alias-pull-fetch>>
<<alias-review>>
<<alias-delete-remote-branch>>
<<alias-cof>>

```

### rebase-branch

main から分岐した時点以降のコミットを対話的リベースで整理する。PR を出す前にコミットをまとめ直すときに使う。

``` {.zsh #alias-rebase-branch}
  rebase-branch = "rebase -i $(git merge-base HEAD main)"
```

### emptycommit

「空コミット」というメッセージで、変更のないコミットを作る。ブランチの起点作りや CI の再実行、空のPR作成に使う。

``` {.zsh #alias-emptycommit}
  emptycommit = "commit --allow-empty -m "空コミット""
```

### logo

コミット履歴を 1 行ずつ簡潔に表示する。

``` {.zsh #alias-logo}
  logo = "log --oneline"
```

### delete-merged-branch

引数のブランチに切り替え、そこへマージ済みのローカルブランチを削除する。現在のブランチと develop・dev・main は消さない。

``` {.zsh #alias-delete-merged-branch}
  delete-merged-branch = "!f () { git checkout $1; git branch --merged|egrep -v '\\*|develop|dev|main'|xargs git branch -d; };f"
```

### copy-branch

現在のブランチ名を改行なしでクリップボードにコピーする。macOS の pbcopy を使う。

``` {.zsh #alias-copy-branch}
  copy-branch = "!f() { git branch --show-current | tr -d '\n' | pbcopy; echo 'Current branch name copied to clipboard.'; }; f"
```

### pull-fetch

`git pull <remote> <branch>` と fetch を行った後、`delete-merged-branch` でマージ済みブランチを掃除する。

``` {.zsh #alias-pull-fetch}
  pull-fetch = "!f() { git pull $1 $2 && git fetch $1 && git delete-merged-branch; }; f"
```

### review

`origin/<ブランチ名>` を追跡するローカルブランチを作って切り替える。PR のレビューでブランチを手元に持ってくるときに使う。

``` {.zsh #alias-review}
  review = "!f() { git checkout -b \"$1\" \"origin/$1\"; }; f \"$@\""
```

### delete-remote-branch

fetch でリモートの削除を反映し、追跡先のリモートブランチが消えたローカルブランチを強制削除する。

``` {.zsh #alias-delete-remote-branch}
  delete-remote-branch = "!git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D"
```

### cof

リモートを含む全ブランチを fzf で選び、そのブランチに切り替える。

``` {.zsh #alias-cof}
  cof = !git branch -a | fzf | xargs git checkout
```

## 初期ブランチ

`git init` で作るリポジトリの初期ブランチ名を main にする。

``` {.zsh #init}
[init]
	defaultBranch = main

```

## 安全なディレクトリ

所有者が自分ではないディレクトリでも Git 操作を許可する。nix-darwin の設定ディレクトリは root 所有なので、ここで明示的に許可している。
使用していない認識。削除予定

``` {.zsh #safe}
[safe]
	directory = /private/etc/nix-darwin

```

## Git LFS

大きなファイルを Git LFS で扱うためのフィルタ。`git lfs install` で自動的に追加される設定。
使用していない認識。削除予定

``` {.zsh #lfs}
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
```
