Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_max_num_candidates = 15
" let g:ycm_disable_signature_help = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
nmap <F2> :YcmCompleter RefactorRename<Space>
nmap <F10> :YcmCompleter GoToImplementation<CR>
nmap gd :YcmCompleter GoToDefinition<CR>
nmap ge :YcmCompleter GoToReferences<CR>
if has('nvim')
  nmap <c-space> <Plug>(YCMHover)
else
  nmap <c-@> <Plug>(YCMHover)
endif
