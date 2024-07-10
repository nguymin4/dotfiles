Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Reveal file and change cwd - in case the file is out of scope of current cwd
nnoremap <Leader>e :NvimTreeFindFile!<CR>
nnoremap <Leader>t :NvimTreeToggle<CR>

function SetupNvimTree()
  lua require('custom/nvim-tree')
endfunction
