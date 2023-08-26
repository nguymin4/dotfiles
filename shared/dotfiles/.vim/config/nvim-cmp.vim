" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'creativenull/efmls-configs-nvim'

" vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

" Diagnostics
" trouble.nvim is enabled even in vim which causes startup issue
if has('nvim')
  Plug 'folke/trouble.nvim'
endif

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set completeopt-=preview
set signcolumn=yes

function SetupNvimCmp()
  lua require('custom/nvim-cmp')
  lua require('custom/mason')
  lua require('custom/lsp')
endfunction
