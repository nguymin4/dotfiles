Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

function SetupGitSigns()
  lua require('custom/gitsigns')
endfunction
