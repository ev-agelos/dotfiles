dir=~/dotfiles
olddir=~/dotfiles_old
files="bash/.bashrc vim/.vimrc gvim/.gvimrc nvim/.nvimrc hg/.hgrc zsh/.zshrc tmux/.tmux.conf ssh/.sshconfig git/.gitignore_global"

echo "Creating $olddir for backup of any existing dorfiles in ~"
mkdir -p $olddir
echo "...done"

for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/$file ~/dotfiles_old/
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/$file
done

source ~/.bashrc
