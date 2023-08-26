set -euo pipefail

# neovim LSP support
function install_efm_ls() {
  scoop install go
  go install github.com/mattn/efm-langserver@latest
}

# fzf
function install_fzf() {
  rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-update-rc
}

# python
function install_python() {
  scoop install python310
  pip install pynvim
  scoop install mambaforge
}

# Print CLI usage
help() {
  cat << EOF
Usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install all dev tools
    --efm-ls
    --fzf
    --python
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
        install_efm_ls
        install_fzf
        install_python
      )
      break
      ;;
    --efm-ls)   install_fns+=(install_efm_ls) ;;
    --fzf)      install_fns+=(install_fzf) ;;
    --python)   install_fns+=(install_python) ;;
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
