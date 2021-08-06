Plug 'junegunn/limelight.vim'
nnoremap <F1> :Limelight!!<CR>
"Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
let g:limelight_default_coefficient = 0.2
" let whitelist = ['javascript', 'typescript', 'python']
" autocmd WinEnter,BufEnter * if index(whitelist, &ft) >= 0 | Limelight | else | Limelight! | endif
" autocmd WinLeave,BufLeave * if index(whitelist, &ft) < 0 | Limelight!

