# My personal dotfile repo

This repository is meant for personal use, but feel free to take inspiration from it or use it.

I took inspiration from [this blog post](https://drewdevault.com/2019/12/30/dotfiles.html).
The only difference is that, instead of using `git add -f filename`, I modify the `.gitignore` accordingly.

It contains:
- bash scripts
- alacritty configurations
- tmux configurations
- bash configurations
- images
- git global configs


My [Neovim configuration](https://github.com/elia-b/NeovimConfig) is separate.

## Environment Variables

Ensure the following `.env` file is present for proper functionality:

```bash
export DOTFILES_PROJECTS_PATH=
export DOTFILES_OBSIDIAN_VAULT=
export DOTFILES_DEVCONTAINER=
export DOTFILES_DEVCONTAINER_COMPLETION=
export DOTFILES_BOOKMARKS_BACKUP=
```
