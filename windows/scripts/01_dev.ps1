# python
scoop install python310
pip install pynvim
scoop install mambaforge

# neovim LSP support
scoop install go
if (Check-Command -cmdname 'go') {
  go install github.com/mattn/efm-langserver@latest
}
