#!/usr/bin/env sh

SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

echo $SELF_PATH

ruby vim-update-bundles

ln -sf $SELF_PATH/bashrc ~/.bashrc
ln -sf $SELF_PATH/screenrc ~/.screenrc
ln -sf $SELF_PATH/tmux.conf ~/.tmux.conf

rm -rf ~/.vim
ln -sf $SELF_PATH/vim/vimrc ~/.vimrc
ln -sf $SELF_PATH/vim ~/.vim

ln -sf $SELF_PATH/gitconfig ~/.gitconfig

ln -sf $SELF_PATH/xinitrc ~/.xinitrc
ln -sf $SELF_PATH/Xdefaults ~/.Xdefaults
ln -sf $SELF_PATH/gtkrc-2.0 ~/.gtkrc-2.0
