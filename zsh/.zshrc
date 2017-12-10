# Source aliases
source $HOME/.aliases

eval "$(fasd --init auto)"

# Show the host name only when different that the default evagelos
export DEFAULT_USER=evagelos
# Allow tmux to set $TERM(to solve function keys not working problem)
[[ $TMUX = "" ]] && export TERM="xterm-256color"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-messages --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--border --cycle'
export FZF_TMUX=1
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_OPTS="--preview 'coderay {} 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_ALT_C_COMMAND="bfs -type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Use Shift+Tab for previous selection
bindkey '^[[Z' reverse-menu-complete
# Ctrl+U to delete chars from cursor position to beginning of line
bindkey \^U       backward-kill-line
bindkey  "^[[H"   beginning-of-line  # HOME key
bindkey  "^[[F"   end-of-line        # END key
bindkey '\e[3~'   delete-char        # DEL key

HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt BEEP
setopt LIST_BEEP
# Share history between zsh shells
setopt SHARE_HISTORY  # reloads the history whenever you use it
setopt AUTOCD
setopt LIST_PACKED
setopt INTERACTIVE_COMMENTS
setopt MENU_COMPLETE

# Enable advanced completion
autoload -U compinit && compinit
# Highlight menu selection
zstyle ':completion:*' menu select
# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# ignore some directories
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#*.egg-info|' '(*/)#__pycache__'
# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

###############################################################
source ~/.zplug/init.zsh

# Customize geometry theme
PROMPT_VIRTUALENV_ENABLED=true
PROMPT_GEOMETRY_RPROMPT_ASYNC=false
PROMPT_GEOMETRY_GIT_TIME=false
GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git docker_machine)

# Plugins
zplug "frmendes/geometry"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "jarun/googler", use:auto-completion/zsh/
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "peterhurford/git-it-on.zsh"
# zplug "changyuheng/zsh-interactive-cd"
zplug "wfxr/forgit", defer:1
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
  fi
}
