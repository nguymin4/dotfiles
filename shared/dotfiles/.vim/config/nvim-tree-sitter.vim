" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

function SetupNvimTreeSitter()
  lua require('custom/nvim-tree-sitter')
endfunction
