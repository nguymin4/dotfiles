alias sync="rsync -avi --recursive --relative --exclude='*.swp'"
alias sync-config="sync --files-from=$HOME/Programs/Scripts/rsync-config"
alias sync-dotfiles="sync --files-from=$HOME/Programs/Scripts/rsync-dotfiles"
alias backup-config="sync-config --delete $HOME"
alias backup-dotfiles="sync-dotfiles --delete $HOME"
alias check-gpu="glxinfo | egrep 'OpenGL vendor|OpenGL renderer*'"
alias fd=fdfind
alias mux=tmuxinator
alias rg="rg --hidden --glob '!.git'"
alias switch-monitor="xrandr --output eDP-1-1 --off --output eDP-1 --off"
alias system-clean="sudo apt autoremove --purge && sudo apt autoclean"
alias system-update="sudo apt update && sudo apt full-upgrade -y"
alias test-truecolor="printf \"\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n\""
alias vi=nvim
alias vscode=code
