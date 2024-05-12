# dotfiles

# Make Command
セットアップは、[Makefile](./Makefile) で行う

- `make init` : 最初のプリファレンスを設定する。
- `make link` : dotfiles をリンクさせる
- `make brew` : [.Brewfile](./.bin/.Brewfile)にある物を `brew install` する。   
- `make update` : [.Brewfile](./.bin/.Brewfile)にある物を更新することができる。
