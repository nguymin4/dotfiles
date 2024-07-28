" Theme
Plug 'sainnhe/edge'

" misc
Plug 'terryma/vim-expand-region'
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=180

" highlight yank
if has('nvim')
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="HighlightedYankRegion", timeout=250 })
  highlight HighlightedYankRegion cterm=reverse gui=reverse
endif
