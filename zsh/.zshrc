source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle mercurial

# Bundles

POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=20
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(os_icon history status)
antigen theme bhilburn/powerlevel9k powerlevel9k

# Tell antigen that you're done.
antigen apply

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$Home/Devel
source /usr/local/bin/virtualenvwrapper.sh

export TERM=xterm-256color
# Make en_US default locale
# export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LC_ALL=nl_NL.UTF-8
# export LANGUAGE=nl_NL.UTF-8

# Next export must be false in order to show virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=false
export DEFAULT_USER=evagelos

# Use solarized colors for dirs
eval `dircolors ~/.dir_colors`

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
#zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

alias vi=nvim
