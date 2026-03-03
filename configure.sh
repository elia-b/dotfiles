#!/bin/bash
# This script creates symbolic links for the files in the repo 
# and where the system expects them

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Prepare directory structure
mkdir -p $HOME/.config 
mkdir -p $HOME/.local/bin
mkdir -p $HOME/Projects 
ln -s /run/media ~/Usb

# tmux is configured in .config/tmux/tmux.conf
# otherwise would be not seen
rm -rf "$HOME/.tmux.conf"

# Apps configuration in .config
for app in tmux bash containers yazi speak; do
  src="$script_dir/$app"
  tgt="$HOME/.config/$app"

  if [[ -e "$tgt" ]]; then
      echo "⚠ WARNING: $tgt already exists — not replacing"
      continue
  fi

  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

# Add scripts to .local/bin
for app in bin/*; do
    echo $app
    [[ -f "$app" ]] || continue

    src="$script_dir/$app"
    tgt="$HOME/.local/$app"

    if [[ -e "$tgt" ]]; then
        echo "⚠ WARNING: $tgt already exists — not replacing"
        continue
    fi

    ln -s "$src" "$tgt"
    echo "Linked $src → $tgt"
done

# Replace files in home directory
# for bash and git
for conf in .bashrc .profile .gitconfig; do
  src="$script_dir/$conf"
  tgt="$HOME/$conf"

  if [[ -e "$tgt" ]]; then
      echo "⚠ WARNING: $tgt already exists — not replacing"
      continue
  fi
  
  rm -f "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

