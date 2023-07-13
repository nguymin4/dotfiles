Plug 'ryanoasis/vim-devicons'
" Plug 'chriskempson/base16-vim'
Plug 'tinted-theming/base16-vim'
let base16_background_transparent = 1

if has('nvim')
  Plug 'navarasu/onedark.nvim'
  let g:onedark_config = {
    \ 'style': 'dark',
    \ 'diagnostics': {
      \ 'undercurl': v:true,
    \ },
  \}
else
  Plug 'joshdick/onedark.vim'
  let g:onedark_terminal_italics = 1
endif

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
