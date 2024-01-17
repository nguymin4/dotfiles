Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
nmap <leader>gs <Plug>(GitGutterStageHunk)
vmap <leader>gs <Plug>(GitGutterStageHunk)
nnoremap <leader>4 :GitGutterLineHighlightsToggle<CR>
