color_prompt=yes
_GREEN=$(tput setaf 2)
_YELLOW=$(tput setaf 3)
_BLUE=$(tput setaf 4)
_RED=$(tput setaf 1)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)
PS1="${_GREEN}\u@\h${_RESET} ${_YELLOW}\w${_RESET}"

# GIT bash integration
if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
  source /usr/lib/git-core/git-sh-prompt
  source /usr/share/bash-completion/completions/git

  export GIT_PS1_SHOWCOLORHINTS=true
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWUPSTREAM="auto"
  PS1+="${_BLUE}\$(__git_ps1)${_RESET}"
  export PROMPT_COMMAND=echo
fi
PS1+="${_GREEN}\n➔${_RESET} "

alias ls='ls --color=auto'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
