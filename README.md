# dotfiles

## Setup

Install はスクリプト実行する。

```sh
zsh setup.sh
```

Homebrew は、Brewfile で管理している。
Brewfile で管理しているツールを導入したい場合は以下のように導入する。

```sh
brew bundle
```

詳細は[Brewfileの使い方]() を参照

## 追加方法

追加したいファイル作成・記述して再度、

```sh
zsh setup.sh
```

を行う。

## Brewfileの使い方

ここでは、Birewfile の基本的な使い方を紹介する。

### 追加

`brew install` で追加したら、以下のコマンドを入力する。

```sh
brew bundle dump
```

### 削除

`brew uninstall` した場合は、以下のコマンドを入力する。

```sh
brew bundle cleanup
```
