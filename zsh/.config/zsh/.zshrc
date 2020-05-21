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
export FZF_DEFAULT_COMMAND='\fd --hidden --follow --type file'
export FZF_DEFAULT_OPTS='--border --cycle'
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'coderay {} 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_ALT_C_COMMAND="bfs ! -type d -o -readable -o -prune"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # fix for killing backwards word in paths
FIGNORE=".pyc:.git"  # seperate with : for multiple extensions
KEYTIMEOUT=1
HISTFILE=$XDG_DATA_HOME/zsh/history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY  # reloads the history whenever you use it
setopt APPENDHISTORY
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt AUTOCD
setopt LIST_PACKED
setopt INTERACTIVE_COMMENTS
setopt MENU_COMPLETE  # do not autoselect the first completion entry
setopt GLOBDOTS  # Do not require a leading '.' in a filename to be matched explicitly

zstyle ':completion:*' menu select  # Highlight menu selection
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#*.egg-info|' '(*/)#__pycache__'  # ignore some directories
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
#################### Plugins/Plugin Manager ########################
# Geometry theme options
GEOMETRY_COLOR_PROMPT=blue
GEOMETRY_COLOR_JOBS=green
GEOMETRY_PATH_COLOR=yellow
PROMPT_VIRTUALENV_ENABLED=true
PROMPT_GEOMETRY_RPROMPT_ASYNC=false
PROMPT_GEOMETRY_GIT_TIME=false
GEOMETRY_PROMPT=(geometry_virtualenv geometry_status geometry_path geometry_jobs)
GEOMETRY_RPROMPT=(geometry_exitcode geometry_exec_time geometry_git)

declare -A ZPLGM
ZPLGM[HOME_DIR]=$XDG_CONFIG_HOME/zplugin
ZPLGM[ZCOMPDUMP_PATH]=$ZDOTDIR/zcompdump
source $XDG_CONFIG_HOME/zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light geometry-zsh/geometry
zplugin ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zplugin light trapd00r/LS_COLORS
zplugin ice as"program" from"gh-r" bpick"*linux_amd64*"
zplugin light junegunn/fzf-bin
zplugin ice as"completion"
zplugin snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zplugin snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zplugin ice pick"/dev/null" id-as"fzf" cloneonly atclone"mkdir plugin && mv fzf plugin/fzf.vim" atpull'%atclone'
zplugin snippet https://github.com/junegunn/fzf/blob/master/plugin/fzf.vim
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light kutsan/zsh-system-clipboard
zplugin ice ver"tig-2.4.1" pick"/dev/null" make"prefix=$HOME/.local all install"
zplugin light jonas/tig
zplugin ice as"program" atclone'./fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| zhook.zsh' atpull'%atclone' src'zhook.zsh'
zplugin light whjvenyl/fasd
zplugin ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zplugin light tj/git-extras
zplugin light peterhurford/git-it-on.zsh
zplugin light soimort/translate-shell
zplugin ice wait"2" lucid as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy
zplugin ice wait"0" atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting
####################################################################

source $XDG_CONFIG_HOME/zsh/functions
source $XDG_CONFIG_HOME/aliases  # my aliases

# Note: Bind keys in the end because of conflict with zsh-syntax-highlighting(fast-syntax-highlighting)
# needs to be loaded first and then bind keys

# Map what keyboard sends for specific keys to zsh actions
bindkey '^[[Z'    reverse-menu-complete # Shift+tab for previous selection
bindkey "^?"      backward-delete-char  # Backspace

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# Use Ctrl+V and type your key to see what sends to the terminal
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
