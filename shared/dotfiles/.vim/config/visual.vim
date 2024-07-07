" Theme
Plug 'sainnhe/edge'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_list_order = ['dir', 'commands']

" quickscope
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=180

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
