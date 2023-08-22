#!/bin/bash

set -euo pipefail

function get_latest_tag_from_github() {
  GITHUB_REPO_URL="https://github.com/$1"
  curl -s "${GITHUB_REPO_URL}/tags" | grep -w releases | grep -o '[0-9]\.[0-9]*\.[0-9-]*' | grep -v - | head -n 1
}

# fnm
function install_fnm() {
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
  eval "`fnm env --use-on-cd`"
  fnm install --lts && fnm use lts-latest && npm install -g yarn
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
  curl -fsSL https://install.julialang.org | sh
}


# misc
function install_misc() {
  sudo apt install -y watchman ranger tig neofetch btop stress-ng
}


# mkcert
function install_mkcert() {
  sudo apt install -y libnss3-tools
  MKCERT_VERSION=$(get_latest_tag_from_github 'FiloSottile/mkcert')
  curl -L "https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64" -o ~/.local/bin/mkcert
  chmod u+x ~/.local/bin/mkcert
  # ~/.local/bin/mkcert install
}


# PgAdmin4
function install_pgadmin4() {
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install -y pgadmin4
}


# pyenv
function install_pyenv() {
  rm -rf ~/.pyenv && git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
  [[ ! $(grep 'PYENV' ~/.zprofile) ]] && cat <<-'EOH' >> ~/.zprofile

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -s "$PYENV_ROOT/bin/pyenv" ] && eval "$(pyenv init --path)"
EOH
}


# tfenv
function install_tfenv() {
  rm -rf ~/.tfenv && git clone https://github.com/tfutils/tfenv.git ~/.tfenv
  ln -s ~/.tfenv/bin/* ~/.local/bin
}


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
    --mkcert
    --pgadmin4
    --pyenv
    --tfenv
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
        install_mkcert
        install_pyenv
        install_tfenv
      )
      break
      ;;
    --fnm)        install_fns+=(install_fnm) ;;
    --gcloud)     install_fns+=(install_gcloud) ;;
    --heroku)     install_fns+=(install_heroku) ;;
    --juliaup)    install_fns+=(install_juliaup) ;;
    --misc)       install_fns+=(install_misc) ;;
    --mkcert)     install_fns+=(install_mkcert) ;;
    --pgadmin4)   install_fns+=(install_pgadmin4) ;;
    --pyenv)      install_fns+=(install_pyenv) ;;
    --tfenv)      install_fns+=(install_tfenv) ;;
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
