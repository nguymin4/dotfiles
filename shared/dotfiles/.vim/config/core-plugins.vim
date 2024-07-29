packadd! matchit
packadd! cfilter

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'christoomey/vim-tmux-navigator'

nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" search
Plug 'mileszs/ack.vim'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ackhighlight = 1

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
