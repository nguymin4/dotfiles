" For nvim
let g:python3_host_prog='/usr/bin/python'

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
source ~/.vim/config/coc.vim
source ~/.vim/config/fzf.vim
source ~/.vim/config/indent-line.vim
source ~/.vim/config/startify.vim
source ~/.vim/config/quickscope.vim
source ~/.vim/config/visual-mode.vim
source ~/.vim/config/languages.vim
source ~/.vim/config/theme.vim

call plug#end()

source ~/.vim/colorschemes/default.vim
highlight HighlightedyankRegion cterm=reverse gui=reverse
