set -o vi
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/.bash_aliases

eval "$(starship init bash)"
