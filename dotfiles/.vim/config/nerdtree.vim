Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeWinPos = 'left'
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeHijackNetrw=0
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ 'Modified'  : '•',
  \ 'Staged'    : '✚',
  \ 'Untracked' : 'ᵁ',
  \ 'Renamed'   : '≫',
  \ 'Unmerged'  : '≠',
  \ 'Ignored'   : 'ⁱ',
  \ 'Deleted'   : '✖',
  \ 'Dirty'     : '•',
  \ 'Unknown'   : '⁇'
  \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
" TODO: Remove this temporarily workaround for devicon deprecation warning
let g:NERDTreeGitStatusLogLevel = 3
let NERDTreeMinimalUI = 1
let NERDTreeHighlightCursorline=0
let NERDTreeAutoDeleteBuffer = 1
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>e :NERDTreeFind<CR>
autocmd FileType nerdtree set cursorline signcolumn=no
