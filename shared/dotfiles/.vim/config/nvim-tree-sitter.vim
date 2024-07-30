" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'chrisbra/csv.vim'
Plug 'mtdl9/vim-log-highlighting'

" This plugin works well with embedded languages
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lukas-reineke/indent-blankline.nvim'

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
