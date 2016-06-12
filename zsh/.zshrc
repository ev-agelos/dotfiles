source ~/.zplug/init.zsh

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
POWERLEVEL9K_CHANGESET_HASH_LENGTH=20
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

zplug "zsh-users/zsh-completions"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# export TERM=xterm-256color
# # Pyenv
# export PATH="/home/evagelos/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
 
# Next export must be false in order to show virtualenv in PowerLevel9k
export VIRTUAL_ENV_DISABLE_PROMPT=false
# Show the host name only when different that the default evagelos
export DEFAULT_USER=evagelos
 
# # Use solarized colors for files/directories
alias ls="ls --color"
eval `dircolors ~/repos/dircolors-solarized/dircolors.256dark`
# source ~/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh
 
# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
