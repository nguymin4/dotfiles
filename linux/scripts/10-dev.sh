#!/bin/bash

set -euo pipefail

linux_script_folder=$(dirname "$(realpath "$0")")
dotfiles_root="$linux_script_folder/../.."
mac_dev_script=$(realpath "$dotfiles_root/mac/scripts/10-dev.sh")


# fnm
function install_fnm() {
  bash "$mac_dev_script" --fnm
}

# gcloud
function install_gcloud() {
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  sudo apt update && sudo apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin kubectl
}

# goenv
function install_goenv() {
  bash "$mac_dev_script" --goenv
}

# Heroku
function install_heroku() {
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  heroku plugins:install heroku-accounts
}

# juliaup
function install_juliaup() {
  bash "$mac_dev_script" --juliaup
}

# misc
function install_misc() {
  bash "$mac_dev_script" --misc
}

# PgAdmin4
function install_pgadmin4() {
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install -y pgadmin4
}

# pyenv
function install_pyenv() {
  bash "$mac_dev_script" --pyenv
}

# sdkman
function install_sdkman() {
  bash "$mac_dev_script" --sdkman
}

# zig
function install_zig() {
  bash "$mac_dev_script" --zig
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
    --heroku
    --juliaup
    --misc
    --pgadmin4
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
        install_juliaup
        install_misc
        install_pyenv
        install_sdkman
      )
      break
      ;;
    --fnm)        install_fns+=(install_fnm) ;;
    --gcloud)     install_fns+=(install_gcloud) ;;
    --goenv)      install_fns+=(install_goenv) ;;
    --heroku)     install_fns+=(install_heroku) ;;
    --juliaup)    install_fns+=(install_juliaup) ;;
    --misc)       install_fns+=(install_misc) ;;
    --pgadmin4)   install_fns+=(install_pgadmin4) ;;
    --pyenv)      install_fns+=(install_pyenv) ;;
    --sdkman)     install_fns+=(install_sdkman) ;;
    --zig)        install_fns+=(install_zig) ;;
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
