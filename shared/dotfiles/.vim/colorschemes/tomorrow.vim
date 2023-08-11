let g:airline_theme="base16_tomorrow"

let g:defx_icons_gui_colors = {
      \ 'yellow': '969896',
      \ 'default': '969896'
      \ }

let g:defx_icons_term_colors = {
      \ 'yellow': 246,
      \ 'default': 246
      \ }

function! s:base16_customize() abort
  highlight Comment cterm=italic
  call Base16hi("CursorLineNr", g:base16_gui0D, g:base16_gui00, g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("LineNr", g:base16_gui0D, g:base16_gui00, g:base16_cterm0D, g:base16_cterm00, "none", "")
  " call Base16hi("MatchParen", "", g:base16_gui0A, "", g:base16_cterm0A, "", "")
  call Base16hi("Search", g:base16_gui05, "", g:base16_cterm05, "", "", "")
  call Base16hi("SignColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")
  call Base16hi("StartifyFile", g:base16_gui0D, "", g:base16_cterm0D, "", "", "")
  call Base16hi("VertSplit", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "none", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

set background=dark
silent! colorscheme base16-tomorrow
