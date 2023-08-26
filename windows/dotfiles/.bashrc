stty -ixon

set -o vi
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\C-n": history-search-backward'
bind '"\C-p": history-search-forward'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.bash_aliases

eval "$(starship init bash)"
