set encoding=utf-8
set fileencodings=utf-8
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set foldlevel=99
set foldmethod=syntax
set nofoldenable
set number
set relativenumber
set nocursorline
set guicursor=
set hlsearch
set incsearch
set shortmess-=S
set laststatus=2
set mouse=
set nrformats=
set timeoutlen=1000 ttimeoutlen=10
set splitbelow
set clipboard=unnamedplus
set pastetoggle=<leader>1

noremap <C-s> :w!<CR>
noremap <leader>5 :e!<CR>
noremap <leader>6 :set hlsearch! hlsearch?<CR>

" Close all buffers except current one
command! BufOnly execute '%bdelete|edit#|bdelete#'

" Navigate tabs
nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" Improve vim history key
cmap <C-n> <up>
cmap <C-p> <down>

" Undo from accidental Ctrl+u and Ctrl+w
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Resize faster
nnoremap <C-w>+ :resize +20<CR>
nnoremap <C-w>- :resize -20<CR>
nnoremap <C-w>> :vertical resize +20<CR>
nnoremap <C-w>< :vertical resize -20<CR>

" Maintain visual block when modifying indentation
vnoremap > >gv
vnoremap < <gv

" Clear previous session jumplist
autocmd VimEnter * :clearjumps

syntax on
filetype plugin indent on
