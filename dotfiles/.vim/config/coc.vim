Plug 'neoclide/coc.nvim', { 'branch': 'release' }
let g:coc_config_home = '~/.vim'
let g:coc_global_extensions = [
      \'coc-css',
      \'coc-eslint',
      \'coc-explorer',
      \'coc-json',
      \'coc-julia',
      \'coc-html',
      \'coc-pyright',
      \'coc-snippets',
      \'coc-tsserver',
      \'coc-vimtex',
      \'coc-yaml'
      \]
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set updatetime=250
set completeopt-=preview
set signcolumn=yes

command! -nargs=0 CocFormat :call CocAction('format')
nnoremap <Leader>c :CocCommand<Space>
nmap <F2> <Plug>(coc-rename)
nmap <F8> <Plug>(coc-codeaction)
nmap <leader>f :call CocAction('format')<CR>
xmap <leader>f <Plug>(coc-format-selected)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ge <Plug>(coc-references)
nmap <silent> gE <Plug>(coc-implementation)

" Support both <c-n> and tab for completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion in insert mode and show documentation in normal mode
if has('nvim')
  nnoremap <silent> <c-space> :call <SID>show_documentation()<CR>
  inoremap <silent><expr> <c-space> <SID>trigger_completion()
else
  nnoremap <silent> <c-@> :call <SID>show_documentation()<CR>
  inoremap <silent><expr> <c-@> <SID>trigger_completion()
endif

function! s:show_documentation() abort
 if (index(['vim','help'], &filetype) >= 0)
   execute 'h '.expand('<cword>')
 else
   call CocActionAsync('doHover')
 endif
endfunction

function! s:trigger_completion() abort
  return coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<c-n>" :
    \ coc#refresh()
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" coc-explorer
nnoremap <Leader>t :CocCommand explorer<CR>
nnoremap <Leader>e :call <SID>reveal_file()<CR>
function! s:reveal_file()
  execute 'CocCommand explorer --no-toggle --reveal '.expand('%:p')
  call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:previousBuffer'], [['relative', 0, 'file']])
endfunction

" Custom text objects - very slow
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
