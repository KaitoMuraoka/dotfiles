# Kaito's dotfiles

## Setup

### 1. Homebrew のインストール

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. リポジトリのクローン

```sh
git clone https://github.com/KaitoMuraoka/dotfiles.git ~/dotfiles
```

### 3. ツールのインストール

```sh
brew install git gh stow bat eza zoxide git-delta neovim tree fastfetch
```

```sh
brew install go
```

```sh
brew tap daipeihust/tap && brew install im-select
```

バージョンマネージャー:

```sh
brew install nodebrew pyenv rbenv
```

iOS 開発ツール:

```sh
brew install swiftformat swiftlint
```

### 4. gh extension のインストール

```sh
gh extension install seachicken/gh-poi
```

### 5. シンボリックリンクの設定

以下のコードブロックをコピーしてターミナルで実行すると、すべての設定ファイルがシンボリックリンクで同期されます。

```sh
# Shell
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc

# Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/.gitmessage_reviewfix.txt ~/.gitmessage_reviewfix.txt

# Config
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/bat ~/.config/bat
ln -sf ~/dotfiles/.config/gh ~/.config/gh

# Xcode
mkdir -p ~/Library/Developer/Xcode/UserData/KeyBindings
ln -sf ~/dotfiles/xcode/Library/Developer/Xcode/UserData/KeyBindings/MyCustomKeyboard.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/MyCustomKeyboard.idekeybindings
```
