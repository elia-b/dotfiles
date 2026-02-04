# My personal dotfile repo

This repository is meant for personal use, but feel free to take inspiration from it or use it.

Initially, I took inspiration from [this blog post](https://drewdevault.com/2019/12/30/dotfiles.html).
The only difference was that, instead of using `git add -f filename`, I used to modify the `.gitignore` accordingly.

I then realized that I prefer when my home directory is also not a git repository.

It contains:

- bash scripts
- tmux configurations
- bash configurations

My [Sway configuration](https://github.com/elia-b/SwayConfig) and
my [Neovim configuration](https://github.com/elia-b/NeovimConfig) are separate,
so that if in a container I just need my dotfiles + neovim it is easier I do not need to include my sway configs as well.
At the same time I like neovim being separate as well since its configuration tends to be quite complicated with many files.

## Environment Variables

The next are some environment variables meant for personal projects.
So that this repo fully works an `.env` with the following variables should be defined:

```bash
export DOTFILES_PROJECTS_PATH=
export DOTFILES_OBSIDIAN_VAULT=
export DOTFILES_DEVCONTAINER=
export DOTFILES_DEVCONTAINER_COMPLETION=
export DOTFILES_SUDO_PASSWORD="$(pass temp)"
export DOTFILES_BOOKMARKS_BACKUP=
```

## USB soft link

```bash
ln -s /run/media ~/Usb
```
