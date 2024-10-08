# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# include in PATH user's executables
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
    PATH="$HOME/.local/share/coursier/bin:$PATH"
fi

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.local/share
export PATH=$PATH:$(go env GOPATH)/bin

# Follow XDG Base Directory specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export PARALLEL_HOME=$XDG_CONFIG_HOME/parallel
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/rgrc
export RUSTUP_HOME=$XDG_CONFIG_HOME/rustup
export PYLINTHOME=$XDG_CONFIG_HOME/pylint
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export HTTPIE_CONFIG_DIR=$XDG_CONFIG_HOME/httpie
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/notmuchrc
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export LYNX_CFG=~/.config/lynx/lynx.cfg
export LYNX_LSS=~/.config/lynx/lynx.lss

export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export CARGO_HOME=$XDG_DATA_HOME/cargo
export NVM_DIR="$XDG_DATA_HOME"/nvm
export WINEPREFIX=$XDG_DATA_HOME/wineprefixes/default
export PYENV_ROOT=$XDG_DATA_HOME/pyenv

export PATH="$PATH:$PYENV_ROOT/bin"
export PATH="$PATH:$PYENV_ROOT/shims"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

export TMUX_TMPDIR=$XDG_RUNTIME_DIR

export PSQL_HISTORY=$XDG_CACHE_HOME/pg/psql_history
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority

export LESSHISTFILE=-
export LESS="-R"
export EDITOR=nvim
export MANPAGER='nvim --appimage-extract-and-run +Man!'
export TERMINAL=alacritty
export BROWSER=qutebrowser
export WINIT_HIDPI_FACTOR=1.0  # fix wrong dpi for alacritty when connecting 2nd screen
#export GTK_THEME=Adwaita-dark
export GDK_DPI_SCALE=0.9

# for qt5 apps to apply the gtk theme currently being used(needs qt5-styleplugins)
#export QT_QPA_PLATFORMTHEME=gtk2
#export QT_STYLE_OVERRIDE=gtk2
HISTSIZE=99999
HISTFILESIZE=99999
