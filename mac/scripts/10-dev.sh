#!/bin/bash

set -euo pipefail

# docker
function install_docker() {
  brew install docker

  # docker compose as plugin
  mkdir -p ~/.docker/cli-plugins
  ln -sfn $HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
}

# fnm
function install_fnm() {
  brew install fnm
  eval "`fnm env --use-on-cd`"
  fnm install --lts && fnm use lts-latest && npm install -g yarn
}

# Optional
function install_misc() {
  brew install btop juliaup libpq ministati stress-ng tfenv
}

# pyenv
function install_pyenv() {
  brew install pyenv pyenv-virtualenv
  [[ ! $(grep 'PYENV' ~/.zprofile) ]] && cat <<-'EOH' >> ~/.zprofile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -s "$PYENV_ROOT/bin/pyenv" ] && eval "$(pyenv init --path)"
EOH
}


# Print CLI usage
help() {
  cat << EOF

Usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all dev tools
    --fnm
    --misc
    --pyenv
EOF
}

install_fns=()

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0
      ;;
    --all)
      install_fns=(
        install_fnm
        install_pyenv
      )
      break
      ;;
    --fnm)        install_fns+=(install_fnm) ;;
    --misc)      install_fns+=(install_misc) ;;
    --pyenv)      install_fns+=(install_pyenv) ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

if [ ${#install_fns[@]} -eq 0 ]; then
  help
  exit 1
fi

# Run installations
for install_fn in "${install_fns[@]}"; do
  ${install_fn}
done