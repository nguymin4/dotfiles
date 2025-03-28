packadd! matchit
packadd! cfilter

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'inkarkat/vim-ReplaceWithRegister'

" nvim >=0.11 has built-in commenting and vim-unimpaired
if !has('nvim')
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'
endif

" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" search
Plug 'mileszs/ack.vim'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ackprg = 'rg --vimgrep --color=never --hidden --glob=!.git/'
let g:ackhighlight = 1

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
