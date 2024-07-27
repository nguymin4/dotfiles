packadd! matchit

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'christoomey/vim-tmux-navigator'

if !has('nvim') && !empty($WAYLAND_DISPLAY)
  Plug 'kana/vim-fakeclip'
endif
