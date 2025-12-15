# Kaito's dotfiles

## Homebrew 
install homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

install tools from homebrew
```sh
brew install git gh stow bat eza zoxide git-delta neovim tree
```

install [im-select](https://github.com/daipeihust/im-select)

```sh
brew tap daipeihust/tap
brew install im-select
```

install version manager
```sh
brew install nodebrew # Node.js version manager
brew install pyenv # python version manager
brew install rbenv # Ruby version manager
```

install iOS Developer tools
```sh
brew install swiftformat swiftlint
```

# Link contents
Use `stow` command to link the contents:

```sh
cd ~/dotfiles/
stow -v zsh
stow -v editor
stow -v git
stow -v xcode
```
