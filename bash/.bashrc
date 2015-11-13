export SVN_EDITOR=nvim
export GIT_EDITOR=nvim
export HG_EDITOR=nvim
# Exclude files/folders from auto-complete
export FIGNORE=.pyc

. ~/multi-shell-repo-prompt/prompt.sh
. ~/dotfiles/hg-completion.bash
. ~/dotfiles/git-completion.bash

# ---- History settings
# append to same history from all windows
shopt -s histappend
# start commands with a space if they should not get recorded
export HISTCONTROL=ignorespace
# exclude certain things from history
export HISTIGNORE="&:ls:vdir:[bf]g:exit"
# no accidental closing with ctrl-d
export IGNOREEOF=1
# search history with up- and down-key
#"e\[A": history-search-backward
#"e\[B": history-search-forward

# Colors for folders
alias ls='ls --color'

# Alias for opening NeoVim instead of vim
alias vi=nvim
# Alias to open tmux with 256 color support
alias tmux="tmux -2"
# VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$Home/Devel
source /usr/local/bin/virtualenvwrapper.sh
