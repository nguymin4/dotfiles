" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Diagnostics
" trouble.nvim is enabled even in vim which causes startup issue
if has("nvim")
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
