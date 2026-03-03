# My personal dotfiles

This repository is meant for personal use, but feel free to take inspiration from it or use it.

Initially, I took inspiration from [this blog post](https://drewdevault.com/2019/12/30/dotfiles.html).
The only difference was that, instead of using `git add -f filename`, I modified the `.gitignore` instead.

I then realized I prefer my home directory not be a git repository either. So I separated them and used a `configure.sh` script to create symlinks.

It contains:

- bash scripts (aliases, prompt) and shell configuration (.bashrc, .profile)
- tmux configuration
- yazi configuration (file manager)
- container storage configuration
- git configuration
- custom scripts (bin/)

My [Sway configuration](https://github.com/elia-b/SwayConfig) and [Neovim configuration](https://github.com/elia-b/NeovimConfig) are kept separate. This keeps containers light — I can grab just dotfiles + neovim without Sway overhead. Neovim also deserves its own repo since its config is complex with many files.
