# Dotfiles --- Vim

```sh
# Backup/Rename
[ -d $HOME/.vim ] && mv $HOME/.vim $HOME/.vim.bak
[ -f $HOME/.vimrc ] && mv $HOME/.vimrc $HOME/.vimrc.bak
```

```sh
# See https://github.com/vim/vim/commit/c9df1fb35a1866901c32df37dd39c8b39dbdb64a

# Base on XDG Spec (Recommanded)
mkdir -p $HOME/.config/vim
git clone https://github.com/range4-skyz/vim $HOME/.config/vim
```
