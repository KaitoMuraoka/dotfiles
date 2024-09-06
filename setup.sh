#!/bin/bash
DOT_FILES=(.zshrc .gitconfig .vimrc .wezterm.lua .ideavimrc .config)
for file in ${DOT_FILES[@]}
do
        ln -s $HOME/dotfiles/$file $HOME/$file
done


DOT_FILES=(nvim aerospace)
for file in ${DOT_FILES[@]}
do
        ln -s $HOME/dotfiles/.config/$file $HOME/.config/$file
done
