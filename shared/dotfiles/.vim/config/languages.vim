" snippets
Plug 'rafamadriz/friendly-snippets'

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

" Improve gf functionality
Plug 'sam4llis/nvim-lua-gf'
Plug 'tomarrell/vim-npr'
let g:vim_npr_file_names = ['', '.js', '/index.js', '.ts', '/index.ts']
let g:vim_npr_file_types = ['js', 'jsx', 'ts', 'tsx']
autocmd BufEnter *.ts,*.tsx nmap <buffer> gf :call VimNPRFindFile('')<CR>
