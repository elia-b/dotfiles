#!/bin/bash
# This script creates symbolic links for the files in the repo 
# and where the system expects them

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Prepare directory structure
mkdir -p $HOME/.config 
mkdir -p $HOME/.local 
# tmux is configured in .config/tmux/tmux.conf
# otherwise would be not seen
rm -rf "$HOME/.tmux.conf"

# Apps configuration in .config
for app in tmux bash containers vifm; do
  src="$script_dir/$app"
  tgt="$HOME/.config/$app"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

# Add scripts to .local/bin
for app in bin; do
  src="$script_dir/$app"
  tgt="$HOME/.local/$app"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

# Replace files in home directory
# for bash and git
for conf in .bashrc .profile .gitconfig; do
  src="$script_dir/$conf"
  tgt="$HOME/$conf"
  rm -f "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

# Install vifm script for image visualization in terminal
source $script_dir/vifm/install-scripts
