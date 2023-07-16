# Start profiling
# setopt SOURCE_TRACE
# zmodload zsh/zprof

# Disable Ctrl+D to logout and exit
setopt ignoreeof
# Disable lock scroll Ctrl+S
stty -ixon

export LANG=en_US.UTF-8
export EDITOR=$(which nvim)
export BAT_THEME="base16"

# OMZ
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME=""

if [[ ! -d $ZSH ]]; then
  git clone https://github.com/nguymin4/oh-my-zsh.git $ZSH
  bash $ZSH/install-custom-plugins.sh
fi

plugins=(conda-zsh-completion gitfast)
source $ZSH/oh-my-zsh.sh

# source $ZSH_CUSTOM/run-async.zsh
# source $ZSH_CUSTOM/profiling-prompt.zsh
source $ZSH_CUSTOM/misc.zsh
source $ZSH_CUSTOM/syntax-highlighting.zsh # Always before vi-mode.zsh
source $ZSH_CUSTOM/vi-mode.zsh
source $ZSH_CUSTOM/fzf.zsh # Always after vi-mode
source $ZSH_CUSTOM/command-timestamp.zsh
source $ZSH_CUSTOM/color.zsh

# pure-prompt
fpath+=$ZSH_CUSTOM/plugins/pure
autoload -U promptinit; promptinit
prompt pure

# Load the shell dotfiles
for file in ~/.{bash_aliases,path}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Attempt to set TERM correctly
TERMINAL_EMULATOR="$(ps --pid $(ps --pid $$ -o ppid=) -o comm=)"
if [[ "${TERMINAL_EMULATOR}" =~ tmux ]]; then
  TERMINAL_EMULATOR=$(ps --pid "$(($(ps --pid $(ps --pid $(tmux display-message -p "#{client_pid}") -o sid=) -o ppid=)))" -o comm=)
fi
if [[ "$TERMINAL_EMULATOR" == 'alacritty' ]]; then
  export TERM=alacritty
fi

# fnm
if command -v fnm &> /dev/null; then
  eval "`fnm env --use-on-cd`"
fi

# pyenv
export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=1
export PYTHONDONTWRITEBYTECODE=1
export TFHUB_CACHE_DIR=$HOME/.tfhub_modules
if [ -s "$PYENV_ROOT/bin/pyenv" ]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
  eval "$(pyenv init - --no-rehash zsh)"
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/nguymin4/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# End profiling
# zprof
