Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
nmap ghs <Plug>(GitGutterStageHunk)
vmap ghs <Plug>(GitGutterStageHunk)
nnoremap <F4> :GitGutterLineHighlightsToggle<CR>
