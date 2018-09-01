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

# set PATH so it includes my ~/bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# include in the path executables from ~/.local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# include ~/.local/bin in Path (for pip install --user ..)
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# also for python 2
if [ -d "$HOME/.local/lib/python2.7/site-packages" ] ; then
    PATH="$HOME/.local/lib/python2.7/site-packages:$PATH"
fi

export PATH="$HOME/.cargo/bin:$PATH"

if [ -z "$UBUNTU_MENUPROXY" ]
then
  UBUNTU_MENUPROXY=1
fi

export GTK_MODULES
export UBUNTU_MENUPROXY
export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=qutebrowser
export WINIT_HIDPI_FACTOR=1.0  # fix wrong dpi for alacritty when connecting 2nd screen
export RIPGREP_CONFIG_PATH=$HOME/.rgrc

eval `dircolors $HOME/.dir_colors`

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
