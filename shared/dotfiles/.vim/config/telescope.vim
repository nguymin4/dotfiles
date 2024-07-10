Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

function SetupTelescopeNvim()
  lua require('custom/telescope')
endfunction
