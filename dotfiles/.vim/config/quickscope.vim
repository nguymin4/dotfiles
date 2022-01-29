Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=180
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermbg=DarkYellow ctermfg=Black
  autocmd ColorScheme * highlight QuickScopeSecondary ctermbg=DarkMagenta ctermfg=Black
augroup END

