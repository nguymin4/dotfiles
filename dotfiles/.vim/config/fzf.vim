Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
let g:fzf_layout = { 'down' : '40%' }

if has('nvim')
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif
