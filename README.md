# dotfiles

# Make Command
セットアップは、[Makefile](./Makefile) で行う

- `make init` : 最初のプリファレンスを設定する。
- `make link` : dotfiles をリンクさせる
- `make defaults` : Mac自体の環境設定を操作
- `make brew` : [.Brewfile](./.bin/.Brewfile)にある物を `brew install` する。   
- `make update` : [.Brewfile](./.bin/.Brewfile)にある物を更新することができる。

# Defaults Setup
Mac 自体の環境設定を操作。

## Finder
- Show hidden files by defaults
- Show files with all extensions
- Avoid creating .DS_Store files on network volumes

## SystemUIServer
- Display date, day, and time in the menu bar : `'M'月'd'日('E')' H'時'mm'分'ss'秒''`
- Display battery level in the menu bar
- Show Bluetooth in the menu bar

## Other
- Save screenshots as PNGs
