# Start profiling
# setopt SOURCE_TRACE
# zmodload zsh/zprof

export LANG=en_US.UTF-8
export EDITOR=$(which vim)
export BAT_THEME="base16"

# OMZ
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
if [[ ! -d $ZSH ]]; then
  git clone https://github.com/nguymin4/oh-my-zsh.git $ZSH
  bash $ZSH/install-custom-plugins.sh
fi

COMPLETION_WAITING_DOTS="false"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
# ZSH_THEME=${ZSH_THEME:-"honukai"}
ZSH_THEME=""

plugins=(zsh_reload)
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

# Disable Ctrl+D to logout and exit
setopt ignoreeof

# Disable lock scroll Ctrl+S
stty -ixon

# Load the shell dotfiles
for file in ~/.{bash_aliases,path,zprofile}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh" --no-use
  if [ -f "$NVM_DIR/alias/default" ]; then
    NODE_VERSION=$(tr -d 'v' < $NVM_DIR/alias/default)
    export PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"
  fi
fi

export TFHUB_CACHE_DIR=$HOME/.tfhub_modules
export PYTHONDONTWRITEBYTECODE=1
if [ -s "$PYENV_ROOT/bin/pyenv" ]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
  eval "$(pyenv init - --no-rehash zsh)"
  eval "$(pyenv virtualenv-init -)"
fi

# End profiling
# zprof
