Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

nnoremap <leader>p <cmd>lua require'telescope.builtin'.find_files({ find_command = {'fdfind', '--type', 'f', '--hidden', '--exclude', '.git' }})<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

function SetupTelescopeNvim()
  lua require('custom/telescope')
endfunction
