# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# include in PATH user's executables
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# include in PATH user's python2.7 site packages
if [ -d "$HOME/.local/lib/python2.7/site-packages" ] ; then
    PATH="$HOME/.local/lib/python2.7/site-packages:$PATH"
fi

# include in PATH user's python3.6 site packages
if [ -d "$HOME/.local/lib/python3.6/site-packages" ] ; then
    PATH="$HOME/.local/lib/python3.6/site-packages:$PATH"
fi

export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim
export MANPAGER='nvim -c "set ft=man" -'
export TERMINAL=kitty
export BROWSER=qutebrowser
export WINIT_HIDPI_FACTOR=1.0  # fix wrong dpi for alacritty when connecting 2nd screen
export RIPGREP_CONFIG_PATH=$HOME/.rgrc
export GTK_THEME=Adwaita-dark
export GDK_DPI_SCALE=0.9

# for qt5 apps to apply the gtk theme currently being used(needs qt5-styleplugins)
export QT_QPA_PLATFORMTHEME=gtk2
export QT_STYLE_OVERRIDE=gtk2

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Allow RubyGems to be executed
PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"
