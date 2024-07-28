" Theme
Plug 'sainnhe/edge'

" statusline and tabline
if has('nvim')
  Plug 'nvim-lualine/lualine.nvim'
else
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
endif

function SetupLualine()
  lua require('custom/lualine')
endfunction

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
