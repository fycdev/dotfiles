#!/bin/bash

config_folders=(
  'kitty'
  'fish'
  'git'
  'nvim'
  'tmux'
)

for folder in "${config_folders[@]}"
do
  rm -rf "$HOME/.config/$folder"
  ln -s "$PWD/$folder" "$HOME/.config"
done

echo 'Config folder symlinks created.'

