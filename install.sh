#!/usr/bin/env sh

SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

echo $SELF_PATH

ruby vim-update-bundles

ln -sf $SELF_PATH/bashrc ~/.bashrc
ln -sf $SELF_PATH/screenrc ~/.screenrc

rm -rf ~/.vim
ln -sf $SELF_PATH/vim/vimrc ~/.vimrc
ln -sf $SELF_PATH/vim ~/.vim

ln -sf $SELF_PATH/gitconfig ~/.gitconfig

ln -sf $SELF_PATH/xinitrc ~/.xinitrc
ln -sf $SELF_PATH/Xdefaults ~/.Xresources
ln -sf $SELF_PATH/gtkrc-2.0 ~/.gtkrc-2.0

# fix perl-support path hardcode bug with pathogen
# Local template file '/home/mattp/.vim/perl-support/templates/Templates' not readable.
ln -sf $SELF_PATH/vim/bundle/perl-support.vim/perl-support ~/.vim/
rm $SELF_PATH/vim/bundle/perl-support.vim/doc/tags-te
