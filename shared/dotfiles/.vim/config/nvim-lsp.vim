" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'creativenull/efmls-configs-nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'

" vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

" Diagnostics
Plug 'folke/trouble.nvim'

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set completeopt-=preview
set signcolumn=yes

function SetupNvimLSP()
  lua require('custom/lsp')
  lua require('custom/nvim-cmp')
endfunction
