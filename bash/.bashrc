# Set editor for svn, git, mercurial
export SVN_EDITOR=nvim
export GIT_EDITOR=nvim
export HG_EDITOR=nvim

# Important for encodings(different programs brake like zsh/powerline etc)
export LANG=en_US.UTF-8

# Exclude files/folders from auto-complete
export FIGNORE=.pyc

# VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$Home/Devel
source /usr/local/bin/virtualenvwrapper.sh

# 256 color support
export TERM=xterm-256color

# Append to same history from all windows
shopt -s histappend
# start commands with a space if they should not get recorded
export HISTCONTROL=ignorespace
# Exclude certain things from history
export HISTIGNORE="&:ls:vdir:[bf]g:exit"

# No accidental closing with ctrl-d
export IGNOREEOF=1

# Colors for folders
# alias ls='ls --color'

# Alias for opening NeoVim instead of vim
alias vi=nvim

# Open terminal with zsh shell
export SHELL=/usr/bin/zsh
[ -z "$ZSH_VERSION" ] && exec /usr/bin/zsh -l
