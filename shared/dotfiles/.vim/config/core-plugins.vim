packadd! matchit
packadd! cfilter

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'inkarkat/vim-ReplaceWithRegister'

" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" nvim >=0.10 has built-in commenting
if !has('nvim')
  Plug 'tpope/vim-commentary'
endif

" search
Plug 'mileszs/ack.vim'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ackhighlight = 1

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
