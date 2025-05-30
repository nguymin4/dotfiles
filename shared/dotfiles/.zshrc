# Common variables
export LANG=en_US.UTF-8
export EDITOR=$(which nvim)
export BAT_THEME='base16'

# Start profiling
ENABLE_PROFILING='false'
if [[ $ENABLE_PROFILING == 'true' ]]; then
  setopt SOURCE_TRACE
  zmodload zsh/zprof
fi

# Disable some default behaviours
setopt ignoreeof  # Disable Ctrl+D: logout and exit
stty -ixon        # Disable Ctrl+S: lock scroll

# OMZ
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export DISABLE_AUTO_TITLE='true' # Use "export" to be compatible with tmux
DISABLE_AUTO_UPDATE='true'
COMPLETION_WAITING_DOTS='true'
ZSH_THEME=''

if [[ ! -d $ZSH ]]; then
  git clone https://github.com/nguymin4/oh-my-zsh.git $ZSH
  bash $ZSH/install-custom-plugins.sh
fi

plugins=(conda-zsh-completion docker gitfast gnu-utils kubectl minikube)
source $ZSH/oh-my-zsh.sh

# Custom plugins
source $ZSH_CUSTOM/color.zsh
source $ZSH_CUSTOM/syntax-highlighting.zsh
source $ZSH_CUSTOM/vi-mode.zsh
source $ZSH_CUSTOM/fzf.zsh # Always after vi-mode
source $ZSH_CUSTOM/misc.zsh

# Load the shell dotfiles
for file in ~/.{bash_aliases,path}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# fnm
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

# homebrew
if command -v brew &> /dev/null; then
  # gcloud
  gcloud_zsh_files=(
    "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
    "$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
  )
  for file in $gcloud_zsh_files; do [ -f "$file" ] && source "$file"; done

  # sdkman
  export SDKMAN_DIR="$HOMEBREW_PREFIX/opt/sdkman-cli/libexec"
  sdkman_init="${SDKMAN_DIR}/bin/sdkman-init.sh"
  [[ -s "$sdkman_init" ]] && source "$sdkman_init"
fi

# python
export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=1
export PYTHONDONTWRITEBYTECODE=1
export TFHUB_CACHE_DIR=$HOME/.tfhub_modules

# goenv
if command -v goenv &> /dev/null; then
  source $ZSH_CUSTOM/goenv.zsh
  eval "$(goenv init -)" && _goenv-set-path
fi


# Setup prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  # pure-prompt
  fpath+=$ZSH_CUSTOM/plugins/pure
  autoload -U promptinit; promptinit
  prompt pure
fi
source $ZSH_CUSTOM/command-timestamp.zsh

# End profiling
if [[ $ENABLE_PROFILING == 'true' ]]; then
  zprof;
  source $ZSH_CUSTOM/profiling-prompt.zsh
fi
