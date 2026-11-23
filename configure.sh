#!/bin/bash
# This script creates symbolic links for the files in the repo
# and where the system expects them. Safe to run multiple times.
set -euo pipefail

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# link SRC TGT: create a symlink unless TGT already exists
link() {
  local src="$1" tgt="$2"

  if [[ -L "$tgt" && "$(readlink "$tgt")" == "$src" ]]; then
    echo "✓ $tgt already linked"
  elif [[ -e "$tgt" || -L "$tgt" ]]; then
    echo "⚠ WARNING: $tgt already exists — not replacing"
  else
    ln -s "$src" "$tgt"
    echo "Linked $src → $tgt"
  fi
}

# Prepare directory structure
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/Projects"
[[ -e "$HOME/Usb" || -L "$HOME/Usb" ]] || ln -s /run/media "$HOME/Usb"

# tmux is configured in .config/tmux/tmux.conf,
# which tmux ignores if ~/.tmux.conf exists
if [[ -e "$HOME/.tmux.conf" ]]; then
  mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
  echo "Moved ~/.tmux.conf to ~/.tmux.conf.bak"
fi

# Apps configuration in .config
for app in tmux bash yazi; do
  link "$script_dir/$app" "$HOME/.config/$app"
done

# Scripts in .local/bin
for script in "$script_dir"/bin/*; do
  [[ -f "$script" ]] || continue
  link "$script" "$HOME/.local/bin/$(basename "$script")"
done

# Bash and git configuration in the home directory
for conf in .bashrc .profile .gitconfig; do
  link "$script_dir/$conf" "$HOME/$conf"
done

if [[ ! -e "$HOME/.gitconfig.local" ]]; then
  echo "ℹ Create ~/.gitconfig.local with your [user] name and email"
fi
