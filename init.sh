#!/bin/bash

readonly DOTFILES_DIR=$(cd $(dirname $0) && pwd)

ln --symbolic --force --verbose --target-directory=$HOME \
  $DOTFILES_DIR/.zshrc*
