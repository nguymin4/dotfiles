alias backup-dotfiles='bash $HOME/dotfiles/backup.sh'
alias check-gpu='glxinfo | egrep "OpenGL vendor|OpenGL renderer*"'
alias fd='fd --hidden --exclude .git'
alias mux=tmuxinator
alias nvm=fnm
alias rg='rg --hidden --glob=!.git/'
alias restore-dotfiles='bash $HOME/dotfiles/restore.sh'
alias switch-monitor='[[ $(xrandr | grep -w connected | wc -l) -gt 1 ]] && xrandr --output $(xrandr | grep eDP | cut -d " " -f 1) --off'
alias system-clean='sudo apt autoremove --purge && sudo apt autoclean'
alias system-update='sudo apt update && sudo apt full-upgrade -y'
alias test-truecolor='printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"'
alias vi='nvim --listen /tmp/nvim.$(openssl rand -hex 3).pipe'
alias vscode=code
