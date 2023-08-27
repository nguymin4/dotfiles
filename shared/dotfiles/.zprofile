[[ -e ~/.profile ]] && emulate sh -c "source ~/.profile"

# homebrew
HOMEBREW_BINS=(
  /opt/homebrew/bin/brew
  /home/linuxbrew/.linuxbrew/bin/brew
  ~/.homebrew/bin/brew
)

for HOMEBREW_BIN in $HOMEBREW_BINS; do
  if [[ -f $HOMEBREW_BIN ]]; then
    eval "$($HOMEBREW_BIN shellenv)"
    break
  fi
done

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init --path)"
fi
