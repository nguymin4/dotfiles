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
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Misc
Plug 'nvim-lualine/lualine.nvim'
Plug 'stevearc/aerial.nvim'

" Improve gf functionality
Plug 'sam4llis/nvim-lua-gf'

" Latex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_cursorhold_recompile = 0
