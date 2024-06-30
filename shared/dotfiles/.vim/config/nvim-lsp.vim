" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'creativenull/efmls-configs-nvim'

" Improve gf functionality
Plug 'sam4llis/nvim-lua-gf'
Plug 'tomarrell/vim-npr'
let g:vim_npr_file_names = ['', '.js', '/index.js', '.ts', '/index.ts']
let g:vim_npr_file_types = ['js', 'jsx', 'ts', 'tsx']
autocmd BufEnter *.ts,*.tsx nmap <buffer> gf :call VimNPRFindFile('')<CR>

" Diagnostics
Plug 'folke/trouble.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set completeopt-=preview
set signcolumn=yes

" vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

function SetupNvimLSP()
  lua require('custom/lsp')
  lua require('custom/nvim-cmp')
endfunction
