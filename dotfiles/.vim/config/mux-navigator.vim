if $TERM_PROGRAM == 'WezTerm'
  Plug 'numToStr/Navigator.nvim'
else
  Plug 'christoomey/vim-tmux-navigator'
endif

function SetupWezTermNavigator()
  lua << EOF
local navigator_setup, navigator = pcall(require, 'Navigator')
if not navigator_setup then
  return
end
navigator.setup()
vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n', 't'}, '<C-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({'n', 't'}, '<C-j>', '<CMD>NavigatorDown<CR>')
EOF
endfunction
