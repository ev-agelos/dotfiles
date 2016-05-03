dir=~/dotfiles
olddir=~/dotfiles_old
files="bash/.bashrc vim/.vimrc gvim/.gvimrc hg/.hgrc zsh/.zshrc tmux/.tmux.conf git/.gitignore_global pdbpp/.pdbrc.py pylint/.pylintrc"
neovim="nvim/init.vim"
i3="i3/config"
xresources=".Xresources"

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$(basename $file) ~/dotfiles_old/
	echo "Creating symlink to $file in ~ directory."
    ln -s $dir/$file ~/$(basename $file)
done

# Neovim goes inside .config folder
echo "Moving any existing init.vim to $olddir"
mv ~/.config/nvim/init.vim ~dotfiles_old/
echo "Creating symlink to nvim/init.vim in .config directory"
# Create folders if dont exist
mkdir ~/.config/nvim
ln -s $dir/$neovim ~/.config/nvim/init.vim

# i3 folder is hidden
echo "Moving any existing .i3/config to $olddir"
mv ~/.i3/config ~dotfiles_old/
echo "Creating symlink to .i3/config"
# Create folders if dont exist
mkdir ~/.i3
ln -s $dir/$i3 ~/.i3/config

# .Xresources doesnt have a folder
echo "Moving any existing .Xresources to $olddir"
mv ~/.Xresources ~dotfiles_old/
echo "Creating symlink to .Xresources"
ln -s $dir/$xresources ~/.Xresources

source ~/.bashrc
