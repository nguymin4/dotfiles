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
  source ~/.vim/config/telescope.vim
else
  source ~/.vim/config/fzf.vim
endif

let use_nvim_lsp = 1
if !use_nvim_lsp && executable('node')
  " coc.nvim requires nodejs
  source ~/.vim/config/coc.vim
endif

source ~/.vim/config/nvim-cmp.vim
source ~/.vim/config/nvim-tree.vim
source ~/.vim/config/mux-navigator.vim
source ~/.vim/config/languages.vim
source ~/.vim/config/visual.vim
source ~/.vim/config/theme.vim
source ~/.vim/config/misc.vim

call plug#end()

" Setup nvim after plugins are installed
if has('nvim')
  if use_nvim_lsp
    call SetupNvimCmp()
  endif
  call SetupNvimTree()
  call SetupTelescopeNvim()
  call SetupWezTermNavigator()
else
  nnoremap <Leader>t :Lexplore<CR>
endif

" Setup themes
set termguicolors
source ~/.vim/colorschemes/edge-dark.vim
highlight HighlightedYankRegion cterm=reverse gui=reverse
