[[ -e ~/.profile ]] && emulate sh -c "source ~/.profile"

HOMEBREW_BIN=~/.homebrew/bin/brew
[[ -f $HOMEBREW_BIN ]] && eval "$($HOMEBREW_BIN shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -s "$PYENV_ROOT/bin/pyenv" ] && eval "$(pyenv init --path)"
