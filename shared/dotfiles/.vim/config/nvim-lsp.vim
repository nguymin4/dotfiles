" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'creativenull/efmls-configs-nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')


set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set completeopt-=preview
set signcolumn=yes

" Misc
Plug 'stevearc/aerial.nvim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_cursorhold_recompile = 0

" LLM
Plug 'David-Kunz/gen.nvim'
