Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

nnoremap <Leader>t :NvimTreeToggle<CR>
nnoremap <Leader>e :NvimTreeFindFile!<CR>

function SetupNvimTree()
  lua require('custom/nvim-tree')
  lua require('custom/nvim-web-devicons')
endfunction
