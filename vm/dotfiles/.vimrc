set autoindent
set smartindent
set clipboard=unnamedplus
set encoding=utf-8
set fileencodings=utf-8
set foldlevel=99
set foldmethod=syntax
set nofoldenable
set guicursor=
set hlsearch
set incsearch
set shortmess-=S
set laststatus=2
set mouse=
set nrformats=
set number
set relativenumber
" set cursorline
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set timeoutlen=1000 ttimeoutlen=10
set splitbelow

noremap <C-s> :w!<CR>
noremap <leader>5 :e!<CR>
noremap <leader>6 :set hlsearch! hlsearch?<CR>

" Close all buffers except current one
command! BufOnly execute '%bdelete|edit#|bdelete#'

" Improve vim history key
cmap <C-N> <Up>
cmap <C-P> <Down>

" Undo from accidental Ctrl+u and Ctrl+w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Resize faster
nnoremap <c-w>+ :resize +20<CR>
nnoremap <c-w>- :resize -20<CR>
nnoremap <c-w>> :vertical resize +20<CR>
nnoremap <c-w>< :vertical resize -20<CR>

" Maintain visual block when modifying indentation
vnoremap > >gv
vnoremap < <gv

syntax on
filetype plugin indent on
