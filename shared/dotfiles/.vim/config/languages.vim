" Polygot
" octave, matlab: syntax error
" zig: outdated comparing to zig.vim
let g:polyglot_disabled = ['octave', 'matlab', 'zig']

Plug 'sheerun/vim-polyglot'
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks=0
let g:vim_json_syntax_conceal=0

" Latex
Plug 'lervag/vimtex'
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_syntax_conceal_greek = 1
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_cursorhold_recompile = 0

" Zig
Plug 'ziglang/zig.vim'
let g:zig_fmt_autosave = 0
