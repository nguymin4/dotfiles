" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Reveal file and change cwd - in case the file is out of scope of current cwd
nnoremap <Leader>e :NvimTreeFindFile!<CR>
nnoremap <Leader>t :NvimTreeToggle<CR>

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

" others
Plug 'goolord/alpha-nvim'
Plug 'nvim-lualine/lualine.nvim'

" improve gf functionality
Plug 'sam4llis/nvim-lua-gf'
