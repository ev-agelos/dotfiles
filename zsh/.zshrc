source ~/.zplug/init.zsh

# Themes
# Customize geometry
PROMPT_VIRTUALENV_ENABLED=true
GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git hg)
zplug "frmendes/geometry"
# POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_COLOR_SCHEME='dark'
# POWERLEVEL9K_STATUS_VERBOSE=true
# POWERLEVEL9K_SHOW_CHANGESET=false
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "psprint/history-search-multi-word"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
export TERM=xterm-256color
# Next export must be false in order to show virtualenv in PowerLevel9k
export VIRTUAL_ENV_DISABLE_PROMPT=false
# Show the host name only when different that the default evagelos
export DEFAULT_USER=evagelos
 
# # Use solarized colors for files/directories
alias ls="ls --color"
alias ag="ag --color-match 36 --color-line-number 33 --color-path 34"
eval `dircolors ~/repos/dircolors-solarized/dircolors.256dark`
# source ~/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh

# Enable advanced completion
autoload -U compinit && compinit
# Highlight menu completion
zstyle ':completion:*' menu select
# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
