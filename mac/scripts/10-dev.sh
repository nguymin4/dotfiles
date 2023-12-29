#!/bin/bash

set -euo pipefail

# docker
function install_docker() {
  brew install colima docker docker-buildx docker-compose kompose kubectl minikube
  minikube config set driver docker

  # docker plugins
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "$HOMEBREW_PREFIX/opt/docker-buildx/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx
  ln -sfn "$HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose
}

# fnm
function install_fnm() {
  brew install fnm
  eval "$(fnm env --use-on-cd)"
  fnm install --lts && fnm use lts-latest && npm install -g yarn
}

# goenv
function install_goenv() {
  brew install goenv
  latest_version=$(goenv install --list | tail -n1 | xargs)
  goenv install "$latest_version"
  goenv global "$latest_version"
}

# juliaup
function install_juliaup() {
  curl -fsSL https://install.julialang.org | sh
}

# misc
function install_misc() {
  brew install ansible ansible-lint libpq mkcert stress-ng tfenv watchman
  if ! grep -Fq 'libpq/bin' ~/.path; then
    # shellcheck disable=SC2016
    echo 'export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"' >> ~/.path
  fi

  # To build python pymssql
  brew install freetds
}


# pyenv
function install_pyenv() {
  brew install pyenv pyenv-virtualenv
  if ! grep -Fq 'pyenv init' ~/.zprofile; then
    cat <<-'EOH' >> ~/.zprofile
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init --path)"
fi
EOH
  fi
}

# skdman
function install_sdkman() {
  brew tap sdkman/tap
  brew install sdkman-cli

  # There is an issue with sdkman-init.sh unbound shell variables
  set +u
  export SDKMAN_DIR="$HOMEBREW_PREFIX/opt/sdkman-cli/libexec"
  sdkman_init="${SDKMAN_DIR}/bin/sdkman-init.sh"

  # shellcheck disable=SC1090
  [[ -s "$sdkman_init" ]] && source "$sdkman_init"
  sdk install java 11.0.19-ms
  sdk install maven
  set -u
}


#---------------------------------------------#
# Print CLI usage
help() {
  cat << EOF
Usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all dev tools
    --docker
    --fnm
    --juliaup
    --misc
    --pyenv
    --sdkman
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
        install_goenv
        install_misc
        install_pyenv
        install_sdkman
      )
      break
      ;;
    --docker)   install_fns+=(install_docker) ;;
    --fnm)      install_fns+=(install_fnm) ;;
    --goenv)    install_fns+=(install_goenv) ;;
    --juliaup)  install_fns+=(install_juliaup) ;;
    --misc)     install_fns+=(install_misc) ;;
    --pyenv)    install_fns+=(install_pyenv) ;;
    --sdkman)   install_fns+=(install_sdkman) ;;
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
