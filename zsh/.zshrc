source "$HOME/.antigen/antigen.zsh"
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle mercurial

# Themes
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_COLOR_SCHEME=dark
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_VCS_BACKGROUND=green
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=yellow
POWERLEVEL9K_DIR_BACKGROUND=239
POWERLEVEL9K_DIR_FOREGROUND=white
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=246
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=000
POWERLEVEL9K_VIRTUALENV_BACKGROUND=white
POWERLEVEL9K_VIRTUALENV_FOREGROUND=black
POWERLEVEL9K_CHANGESET_HASH_LENGTH=0
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
antigen theme bhilburn/powerlevel9k powerlevel9k

# Bundles
antigen bundle zsh-users/zsh-autosuggestions

# Tell antigen that you're done.
antigen apply

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
export TERM=xterm-256color
# Pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Next export must be false in order to show virtualenv in PowerLevel9k
export VIRTUAL_ENV_DISABLE_PROMPT=false
# Show the host name only when different that the default evagelos
export DEFAULT_USER=evagelos

# Use solarized colors for dirs
eval `dircolors ~/.dir_colors/dircolors.256dark`

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
#zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

# Open NeoVim when typing vi
alias vi=nvim
# Open tmux but attach to session dont create each time new session
tmux attach &> /dev/null
# if [[ ! $TERM =~ screen ]]; then
#     exec tmux
# fi
# source ~/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh
