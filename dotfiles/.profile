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

if [[ "$DESKTOP_SESSION" = "i3" || "$DESKTOP_SESSION" = "sway" ]];
then
    export $(gnome-keyring-daemon -s)
fi

export QT_QPA_PLATFORMTHEME=qt5ct
if [[ "$DESKTOP_SESSION" = "sway" ]];
then
    # This doesn't work with Android Emulator
    # export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORM=xcb
    export XDG_CURRENT_DESKTOP=sway
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in *:/home/nguymin4/.juliaup/bin:*);; *)
    export PATH=/home/nguymin4/.juliaup/bin${PATH:+:${PATH}};;
esac

# <<< juliaup initialize <<<
