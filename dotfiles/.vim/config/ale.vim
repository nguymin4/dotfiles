Plug 'dense-analysis/ale'
let g:ale_set_loclist = 0
let g:ale_sign_column_always = 1
let g:ale_linter_aliases = {
      \ 'jsx': ['javascript'],
      \ 'javascriptreact': ['javascript']
      \}
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'javascriptreact': ['eslint'],
      \   'python': ['flake8'],
      \   'scala': ['scalac'],
      \   'typescript': ['eslint'],
      \}
let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \   'javascriptreact': ['eslint'],
      \   'python': ['autopep8'],
      \   'typescript': ['eslint'],
      \}
let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 1

nmap <F8> <Plug>(ale_fix)
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)
