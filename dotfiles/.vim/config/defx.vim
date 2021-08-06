if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
" let g:defx_icons_enable_syntax_highlight=0

nnoremap <leader>t :Defx<CR>
nnoremap <leader>e :Defx `match(expand('%:p:h'), getcwd()) == 0 ? getcwd() : expand('%:p:h')` -search=`expand('%:p')`<CR>

autocmd VimEnter * call s:defx_my_settings()
autocmd FileType defx call s:defx_my_mappings()

function! s:defx_my_settings() abort
  call defx#custom#option('_', {
    \ 'auto_cd': v:true,
    \ 'columns': 'indent:git:space:icons:space:filename',
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'root_marker': '',
    \ })
  call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': '',
    \ })
  call defx#custom#column('git', 'indicators', {
    \ 'Modified'  : '•',
    \ 'Staged'    : '✚',
    \ 'Untracked' : 'ᵁ',
    \ 'Renamed'   : '≫',
    \ 'Unmerged'  : '≠',
    \ 'Ignored'   : 'ⁱ',
    \ 'Deleted'   : '✖',
    \ 'Unknown'   : '⁇'
    \ })
  let g:defx_icons_mark_icon = ''
  let g:defx_icons_copy_icon = 'c'
  let g:defx_icons_move_icon = 'x'
endfunction

function! s:defx_my_mappings() abort
  set nonumber norelativenumber cursorline
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_tree'):
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> i
  \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> u
  \ defx#do_action('cd', '..')
  nnoremap <silent><buffer><expr><nowait> cd
  \ defx#do_action('cd', fnamemodify(defx#get_candidate().action__path, ':p:h'))
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('search', fnamemodify(defx#get_candidate().action__path, ':h'))
  nnoremap <silent><buffer><expr> X
  \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> R
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> I
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> dd
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> D
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> ma
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> mA
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> mr
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> Y
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> L
  \ defx#do_action('clear_select_all')
endfunction

