" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

function SetupNvimTreeSitter()
  lua require('custom/nvim-tree-sitter')
endfunction
