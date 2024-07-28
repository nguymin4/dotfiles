lua vim.loader.enable()

let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider=0
let g:loaded_ruby_provider = 0

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
require('custom/nvim-tree-sitter')
require('custom/lsp/init')
require('custom/nvim-cmp')
require('custom/telescope')
require('custom/nvim-tree')
require('custom/gitsigns')
require('custom/lualine')
EOF
