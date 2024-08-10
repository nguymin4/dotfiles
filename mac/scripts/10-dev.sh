#!/bin/bash

set -euo pipefail

# fnm
function install_fnm() {
  brew install fnm
  eval "$(fnm env --use-on-cd)"
  fnm install --lts && fnm use lts-latest && npm install -g yarn
}

# gcloud
function install_gcloud() {
  # Check cloud components installation
  brew install --cask google-cloud-sdk
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
  brew install juliaup
}

# misc
function install_misc() {
  brew install act ansible ansible-lint gitleaks hyperfine libpq lefthook mkcert stress-ng tfenv

  # psql
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
}

# skdman
function install_sdkman() {
  brew tap sdkman/tap
  brew install sdkman-cli

  export SDKMAN_DIR="$HOMEBREW_PREFIX/opt/sdkman-cli/libexec"
  sdkman_init="${SDKMAN_DIR}/bin/sdkman-init.sh"

  # There is an issue with sdkman-init.sh unbound shell variables
  set +u
  if [[ -s "$sdkman_init" ]]; then
    # shellcheck disable=SC1090
    source "$sdkman_init"
    sdk install java 11.0.19-ms
    sdk install maven
  fi
  set -u
}

# zig
function install_zig() {
  brew install zig
}


#---------------------------------------------#
# Print CLI usage
help() {
  cat << EOF
Usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all dev tools
    --fnm
    --gcloud
    --goenv
    --juliaup
    --misc
    --pyenv
    --sdkman
    --zig
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
    --fnm)      install_fns+=(install_fnm) ;;
    --gcloud)   install_fns+=(install_gcloud) ;;
    --goenv)    install_fns+=(install_goenv) ;;
    --juliaup)  install_fns+=(install_juliaup) ;;
    --misc)     install_fns+=(install_misc) ;;
    --pyenv)    install_fns+=(install_pyenv) ;;
    --sdkman)   install_fns+=(install_sdkman) ;;
    --zig)      install_fns+=(install_zig) ;;
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
