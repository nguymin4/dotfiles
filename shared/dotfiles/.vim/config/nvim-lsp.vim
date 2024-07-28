" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'creativenull/efmls-configs-nvim'
Plug 'stevearc/aerial.nvim'

" Diagnostics
Plug 'folke/trouble.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set completeopt-=preview
set signcolumn=yes

" vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

" Language specific
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_cursorhold_recompile = 0

" Improve gf functionality
Plug 'sam4llis/nvim-lua-gf'
nnoremap <silent> gf :call GoToFileOrDefinition()<CR>
let g:gfgd_filetypes = ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'terraform']

function! GoToFileOrDefinition()
  " Get the filename under the cursor
  let filename = expand('<cfile>')
  " Expand the tilde in the file path
  let expanded_filename = expand(filename)
  " If the file path is relative, use cwd to create the full path
  if expanded_filename =~# '^\.\{1,2\}\/'
    let expanded_filename = expand('%:p:h') . '/' . expanded_filename
  endif

  let not_found = empty(glob(expanded_filename))
  let is_dir = isdirectory(expanded_filename)
  if index(g:gfgd_filetypes, &ft) >= 0
    if not_found
      lua vim.lsp.buf.definition()
    elseif is_dir
      lua vim.lsp.buf.definition()
      execute "lua nvim_tree_find_file('".expanded_filename."')"
    else
      execute 'normal! gf'
    endif
  else
    if is_dir
      execute "lua nvim_tree_find_file('".expanded_filename."')"
    else
      execute 'normal! gf'
    endif
  endif
endfunction
