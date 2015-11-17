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

# Next export must be false in order to show virtualenv in PowerLevel9k
export VIRTUAL_ENV_DISABLE_PROMPT=false
# Show the host name only when different that the default evagelos
export DEFAULT_USER=evagelos

# Use solarized colors for dirs
eval `dircolors ~/.dir_colors`

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
#zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

# Open NeoVim when typing vi
alias vi=nvim
