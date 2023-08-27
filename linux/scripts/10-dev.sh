#!/bin/bash

set -euo pipefail

dotfiles_root="$(dirname $(realpath $0))/../.."
mac_script=$(realpath $dotfiles_root/mac/scripts/10-dev.sh)


# fnm
function install_fnm() {
  bash $mac_script --fnm
}

# gcloud
function install_gcloud() {
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  sudo apt update && sudo apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin kubectl
}

# Heroku
function install_heroku() {
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  heroku plugins:install heroku-accounts
}

# juliaup
function install_juliaup() {
  bash $mac_script --juliaup
}

# misc
function install_misc() {
  brew install ansible btop mkcert stress-ng tfenv watchman
}

# PgAdmin4
function install_pgadmin4() {
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install -y pgadmin4
}

# pyenv
function install_pyenv() {
  bash $mac_script --pyenv
}

# sdkman
function install_sdkman() {
  bash $mac_script --sdkman
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
    --heroku
    --juliaup
    --misc
    --pgadmin4
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
        install_juliaup
        install_misc
        install_pyenv
      )
      break
      ;;
    --fnm)        install_fns+=(install_fnm) ;;
    --gcloud)     install_fns+=(install_gcloud) ;;
    --heroku)     install_fns+=(install_heroku) ;;
    --juliaup)    install_fns+=(install_juliaup) ;;
    --misc)       install_fns+=(install_misc) ;;
    --pgadmin4)   install_fns+=(install_pgadmin4) ;;
    --pyenv)      install_fns+=(install_pyenv) ;;
    --sdkman)     install_fns+=(install_sdkman) ;;
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
