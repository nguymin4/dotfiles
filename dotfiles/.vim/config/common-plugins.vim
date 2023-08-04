packadd! matchit

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'editorconfig/editorconfig-vim'

if has('nvim')
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}
else
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 250
  let g:highlightedyank_max_lines = 100
endif

if !has('nvim') && !empty($WAYLAND_DISPLAY)
  Plug 'kana/vim-fakeclip'
endif
