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

よく使う操作の短縮形。マージ済み・リモートで消えたブランチの掃除、fzf でのブランチ切り替え、PR レビュー用のチェックアウト、Claude によるコミットメッセージ生成（`--detail` で本文付き）などをまとめている。

``` {.zsh #alias}
[alias]
  rebase-branch = "rebase -i $(git merge-base HEAD main)"
  emptycommit = "commit --allow-empty -m "空コミット""
  logo = "log --oneline"
  delete-merged-branch = "!f () { git checkout $1; git branch --merged|egrep -v '\\*|develop|main'|xargs git branch -d; };f"
  copy-branch = "!f() { git branch --show-current | tr -d '\n' | pbcopy; echo 'Current branch name copied to clipboard.'; }; f"
  pull-fetch = "!f() { git pull $1 $2 && git fetch $1 && git delete-merged-branch; }; f"
  review = "!f() { git checkout -b \"$1\" \"origin/$1\"; }; f \"$@\""
  delete-remote-branch = "!git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D"
  cof = !git branch -a | fzf | xargs git checkout
  aicommit = "!f() { \
  if [ \"$1\" = \"--detail\" ]; then \
    COMMITMSG=$(claude --no-session-persistence --print 'Generate a Git commit message in Japanese based strictly on the contents of `git diff --cached`. Format it as follows: First line: a concise one-line summary. Then a blank line. Then a detailed bullet-point list explaining what was changed and why. Output ONLY the commit message, no extra explanation.'); \
  else \
    COMMITMSG=$(claude --no-session-persistence --print 'Generate ONLY a one-line Git commit message in Japanese. The message should summarize what was changed and why, based strictly on the contents of `git diff --cached`. DO NOT add an explanation or a body. Output ONLY the commit summary line.'); \
  fi; \
  git commit -m \"$COMMITMSG\" -e; \
}; f"

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
