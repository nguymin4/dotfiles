" For nvim
if has('win32')
  let g:python3_host_prog=expand('~/scoop/shims/python3.exe', ':p')
else
  let g:python3_host_prog='/usr/bin/python'
endif
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" Plugins
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if empty(glob('~/.vim/bundles'))
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/bundles')

source ~/.vim/config/basic-settings.vim
source ~/.vim/config/common-plugins.vim
source ~/.vim/config/git.vim
source ~/.vim/config/ack.vim
" source ~/.vim/config/coc.vim

if has('nvim')
  source ~/.vim/config/telescope.vim
else
  source ~/.vim/config/fzf.vim
endif

source ~/.vim/config/nvim-cmp.vim
source ~/.vim/config/nvim-tree.vim
source ~/.vim/config/mux-navigator.vim
source ~/.vim/config/indent-line.vim
source ~/.vim/config/startify.vim
source ~/.vim/config/quickscope.vim
source ~/.vim/config/visual-mode.vim
source ~/.vim/config/languages.vim
source ~/.vim/config/theme.vim

call plug#end()

set termguicolors
source ~/.vim/colorschemes/default.vim
highlight HighlightedyankRegion cterm=reverse gui=reverse

if has('nvim')
  call SetupNvimCmp()
  call SetupNvimTree()
  call SetupTelescopeNvim()
  call SetupWezTermNavigator()
else
  nnoremap <Leader>t :Lexplore<CR>
endif

function ProfilingPerf(log_name)
  echo 'Start profiling ' . fnamemodify(a:log_name, ':p')
  execute 'profile start' a:log_name
  profile file *
  profile func *
endfunction
