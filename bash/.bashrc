# Important for encodings(different programs brake like zsh/powerline etc)
#export LANG=en_US.UTF-8

# Exclude files/folders from auto-complete
export FIGNORE=.pyc

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

source $(pew shell_config)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

