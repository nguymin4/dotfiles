Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Reveal file and change cwd - in case the file is out of scope of current cwd
nnoremap <Leader>e :NvimTreeFindFile!<CR>
nnoremap <Leader>t :NvimTreeToggle<CR>

if has('nvim')
  Plug 'goolord/alpha-nvim'
else
  Plug 'mhinz/vim-startify'
  let g:startify_change_to_dir = 0
  let g:startify_list_order = ['dir', 'commands']
endif
