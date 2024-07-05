if status is-interactive
    # Remove underline
    set fish_color_valid_path

    fish_vi_key_bindings
    bind -M insert \cc 'commandline ""; set fish_bind_mode insert; commandline -f repaint'
    bind -M insert \cn history-prefix-search-backward
    bind -M insert \cp history-prefix-search-forward
    starship init fish | source
end

alias backup-dotfiles='bash $HOME/dotfiles/backup.sh'
alias check-gpu='glxinfo | egrep "OpenGL vendor|OpenGL renderer*"'
alias mux=tmuxinator
alias nvm=fnm
alias system-clean='sudo apt autoremove --purge && sudo apt autoclean'
alias system-update='sudo apt update && sudo apt full-upgrade -y'
alias test-truecolor='printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"'
alias vi=nvim
alias vscode=code

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if type -q conda
    eval conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

