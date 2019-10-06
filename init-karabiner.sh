#!/bin/bash
set -Ceu

readonly DOTFILES_DIR=$(cd $(dirname $0) && pwd)

# Make symbolic link, link to ~/.config/karabiner directory.
# Do not make a symlink to karabiner.json.
# see: https://pqrs.org/osx/karabiner/document.html#configuration-file-path
ln -s $DOTFILES_DIR/karabiner ~/.config
