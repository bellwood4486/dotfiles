#!/bin/bash
set -Ceu

readonly DOTFILES_DIR=$(cd $(dirname $0) && pwd)

edition=unknown;
case "$(uname)" in
  CYGWIN*) edition=cygwin ;;
  Darwin*) edition=darwin ;;
  Linux*)  edition=linux ;;
  MSYS*) edition=msys ;;
esac

ln --symbolic --force --verbose --target-directory=$HOME \
  $DOTFILES_DIR/.bash_profile \
  $DOTFILES_DIR/.bashrc \
  $DOTFILES_DIR/.zshrc \
  $DOTFILES_DIR/.gitconfig \
  $DOTFILES_DIR/.vimrc \
  $DOTFILES_DIR/.gvimrc

ln --symbolic --force --verbose --target-directory=$HOME \
  $DOTFILES_DIR/.*_$edition

# git submodule の初期化
pushd $DOTFILES_DIR/neobundle.vim
git submodule init
git submodule update
popd
