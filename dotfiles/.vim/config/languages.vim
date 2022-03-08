" Extra helpful text objects, may not be needed
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'bps/vim-textobj-python'
Plug 'michaeljsmith/vim-indent-object'

" Polygot
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['octave', 'matlab']
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks=0
let g:vim_json_syntax_conceal=0

" Latex
Plug 'lervag/vimtex'
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_syntax_conceal_greek = 1
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_cursorhold_recompile = 0

" Support ispell and aspell
Plug 'vim-scripts/vimspell'


" JavaScript
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascriptreact'] }
" Plug 'peitalin/vim-jsx-typescript', { 'for': ['typescriptreact'] }
" Plug 'jparise/vim-graphql', { 'for': ['graphql'] }
" Plug 'elzr/vim-json'
" let g:jsx_ext_required = 0
" let g:vim_jsx_pretty_colorful_config = 1
" let g:vim_json_syntax_conceal = 0


" Python
" Plug 'vim-python/python-syntax'
" let g:python_highlight_all = 1


" Octave
" Plug 'jvirtanen/vim-octave', { 'for': ['octave', 'matlab'] }
