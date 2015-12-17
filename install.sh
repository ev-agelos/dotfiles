dir=~/dotfiles
olddir=~/dotfiles_old
files="bash/.bashrc vim/.vimrc gvim/.gvimrc hg/.hgrc zsh/.zshrc tmux/.tmux.conf git/.gitignore_global pdbpp/.pdbrc.py pylint/.pylintrc"
neovim="nvim/init.vim"

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

source ~/.bashrc
