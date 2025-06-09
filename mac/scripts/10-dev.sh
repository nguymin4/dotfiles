#!/bin/bash

set -euo pipefail

# core tools
function install_core_tools() {
  brew install gitleaks hyperfine libpq lefthook tfenv uv

  # psql
  if ! grep -Fq 'libpq/bin' ~/.path; then
    # shellcheck disable=SC2016
    echo 'export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"' >> ~/.path
  fi
}

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
  gcloud components install gke-gcloud-auth-plugin
}

# goenv
function install_goenv() {
  brew install goenv
  latest_version=$(goenv install --list | tail -n1 | xargs)
  goenv install "$latest_version"
  goenv global "$latest_version"
}

# optional tools
function install_optional_tools() {
  brew install act
  brew install ansible ansible-lint
  brew install juliaup
  brew install mkcert
  brew install stress-ng
  brew install zig

  # To build python pymssql
  brew install freetds
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


#---------------------------------------------#
# Print CLI usage
help() {
  cat << EOF
Usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all dev tools
    --core-tools
    --fnm
    --gcloud
    --goenv
    --optional-tools
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
        install_core_tools
        install_fnm
        install_goenv
        install_sdkman
      )
      break
      ;;
    --core-tools)     install_fns+=(install_core_tools) ;;
    --fnm)            install_fns+=(install_fnm) ;;
    --gcloud)         install_fns+=(install_gcloud) ;;
    --goenv)          install_fns+=(install_goenv) ;;
    --optional-tools) install_fns+=(install_optional_tools) ;;
    --sdkman)         install_fns+=(install_sdkman) ;;
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
