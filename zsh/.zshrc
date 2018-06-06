export DEFAULT_USER=evagelos  # show host name when not me
# Colors for less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# FZF options
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-messages --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--border --cycle'
export FZF_TMUX=1
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_OPTS="--preview 'coderay {} 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_ALT_C_COMMAND="bfs -type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Map what keyboard sends for specific keys to zsh actions
bindkey '^[[Z'    reverse-menu-complete # Shift+tab for previous selection
bindkey \^U       backward-kill-line # Ctrl+U delete from cursor till start of line
bindkey \^K       kill-line          # Ctrl+K delete from cursor till end of line
bindkey \^Y       yank
bindkey \^_       undo
bindkey "^?"      backward-delete-char    # fix backspace
bindkey  "^[[H"   beginning-of-line  # HOME key
bindkey  "^[[F"   end-of-line        # END key
bindkey '\e[3~'   delete-char        # DEL key
bindkey '^A'      beginning-of-line  # Ctrl+a
bindkey '^E'      end-of-line        # Ctrl+e
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY  # reloads the history whenever you use it
setopt AUTOCD
setopt LIST_PACKED
setopt INTERACTIVE_COMMENTS
setopt MENU_COMPLETE  # do not autoselect the first completion entry

zstyle ':completion:*' menu select  # Highlight menu selection
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#*.egg-info|' '(*/)#__pycache__'  # ignore some directories
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"  # ignore some files during completion
# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

#################### Plugins/Plugin Manager ########################
# Geometry theme options
PROMPT_VIRTUALENV_ENABLED=true
PROMPT_GEOMETRY_RPROMPT_ASYNC=false
PROMPT_GEOMETRY_GIT_TIME=false
GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git docker_machine)

source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light frmendes/geometry
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light b4b4r07/zsh-vimode-visual
zplugin ice as"program" atclone'./fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| zhook.zsh' atpull'%atclone' src'zhook.zsh'
zplugin light clvv/fasd
zplugin light peterhurford/git-it-on.zsh
zplugin light wfxr/forgit
zplugin ice wait"0" atinit"zpcompinit"
zplugin light zdharma/fast-syntax-highlighting
####################################################################

source ~/.fzf.zsh
source ~/.zsh/functions
source ~/.aliases  # my aliases
