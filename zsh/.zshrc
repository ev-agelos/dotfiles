source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle mercurial

# Bundles

POWERLEVEL9K_MODE='awesome-patched'
antigen theme bhilburn/powerlevel9k powerlevel9k
# Tell antigen that you're done.
antigen apply

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$Home/Devel
source /usr/local/bin/virtualenvwrapper.sh

## Show solarized colors for directories/files etc
##eval `dircolors /home/evagelos/.dir_colors/dircolors.256dark`
# Next export must be false in order to show virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=false
export DEFAULT_USER=evagelos
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(os_icon status history)

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
#zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

alias vi=nvim
