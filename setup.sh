#!/bin/bash

config_folders=(
  'alacritty'
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

