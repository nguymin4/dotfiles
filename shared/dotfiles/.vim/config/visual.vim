" startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_list_order = ['dir', 'commands']

" indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1
let g:indentLine_fileTypeExclude  = ['help', 'startify', 'fzf', 'coc-explorer']

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=180
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermbg=DarkYellow ctermfg=Black
  autocmd ColorScheme * highlight QuickScopeSecondary ctermbg=DarkMagenta ctermfg=Black
augroup END

" highlight yank
if has('nvim')
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="HighlightedYankRegion", timeout=250 })
else
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 250
  let g:highlightedyank_max_lines = 100
endif

" misc
Plug 'terryma/vim-expand-region'
Plug 'dhruvasagar/vim-table-mode'
let g:loaded_table_mode = 0
