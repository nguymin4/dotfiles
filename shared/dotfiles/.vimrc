" In vim, many plugins setup will break without this
set nocompatible

" Setup vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if empty(glob('~/.vim/bundles'))
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Install plugins
call plug#begin('~/.vim/bundles')

source ~/.vim/config/basic-settings.vim
source ~/.vim/config/core-plugins.vim
source ~/.vim/config/git.vim
source ~/.vim/config/ack.vim

if has('nvim')
  source ~/.vim/config/nvim-tree-sitter.vim
  source ~/.vim/config/nvim-lsp.vim
  source ~/.vim/config/nvim-explorer.vim
else
  source ~/.vim/config/languages.vim
  source ~/.vim/config/explorer.vim
endif

source ~/.vim/config/visual.vim
source ~/.vim/config/misc.vim

call plug#end()

" Setup theme
set termguicolors
source ~/.vim/colorschemes/edge-dark.vim
