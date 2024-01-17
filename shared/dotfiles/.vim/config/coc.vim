Plug 'neoclide/coc.nvim', { 'branch': 'release' }
let g:coc_config_home = '~/.vim'
let g:coc_global_extensions = [
      \'coc-css',
      \'coc-eslint',
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

nnoremap <leader>c :CocCommand<Space>
nnoremap <leader>2 <Plug>(coc-rename)
nnoremap <leader>8 <Plug>(coc-codeaction)
nnoremap <leader>f :call CocAction('format')<CR>
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <silent> [w <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]w <Plug>(coc-diagnostic-next)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> go <Plug>(coc-type-definition)
nnoremap <silent> ge <Plug>(coc-references)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gh :call CocAction('diagnosticInfo')<CR>

" Support both <c-n> and tab for completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion in insert mode and show documentation in normal mode
if has('nvim')
  nnoremap <silent> <c-space> :call ShowDocumentation()<CR>
  inoremap <silent><expr> <c-space> TriggerCompletion()
else
  nnoremap <silent> <c-@> :call ShowDocumentation()<CR>
  inoremap <silent><expr> <c-@> TriggerCompletion()
endif

nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

function! ShowDocumentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! TriggerCompletion() abort
  return coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ CheckBackspace() ? "\<c-n>" :
    \ coc#refresh()
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc-explorer
" nnoremap <Leader>t :CocCommand explorer<CR>
" nnoremap <Leader>e :call <SID>reveal_file()<CR>
" function! s:reveal_file()
"   execute 'CocCommand explorer --no-toggle --reveal '.expand('%:p')
"   call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:previousBuffer'], [['relative', 0, 'file']])
" endfunction

" Disable coc.nvim for certain filetypes
" autocmd FileType gitcommit,gitrebase,NvimTree let b:coc_suggest_disable = 1
