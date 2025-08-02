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

lua require('custom')
