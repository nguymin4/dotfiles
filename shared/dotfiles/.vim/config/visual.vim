" Theme
Plug 'sainnhe/edge'
let g:edge_enable_italic = 0
let g:edge_transparent_background = 0

" startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_list_order = ['dir', 'commands']

" misc
Plug 'terryma/vim-expand-region'
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 180

" highlight yank
if has('nvim')
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup='HighlightedYankRegion', timeout=250 })
endif
