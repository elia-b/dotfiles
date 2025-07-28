#!/bin/bash

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

rm -rf "$HOME/.tmux.conf"
mkdir -p $HOME/.config 
mkdir -p $HOME/.local 

for app in tmux bash containers vifm; do
  src="$script_dir/$app"
  tgt="$HOME/.config/$app"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

for app in bin; do
  src="$script_dir/$app"
  tgt="$HOME/.local/$app"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

for conf in .bashrc .profile; do
  src="$script_dir/$conf"
  tgt="$HOME/$conf"
  rm -f "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

source $script_dir/vifm/install-scripts
