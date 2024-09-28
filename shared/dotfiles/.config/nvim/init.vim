" Disable netrw for nvim-tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0

lua vim.loader.enable()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
require('custom/nvim-tree-sitter')
require('custom/lsp/init')
require('custom/nvim-cmp')
require('custom/explorer/init')
require('custom/gitsigns')
require('custom/lualine')
require('custom/ollama')
EOF
