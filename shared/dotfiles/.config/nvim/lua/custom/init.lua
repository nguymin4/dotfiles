require('custom/nvim-tree-sitter')
-- require('custom/nvim-cmp')
require('custom/blink-cmp')
require('custom/lsp')
require('custom/explorer')
require('custom/gitsigns')
require('custom/lualine')
require('custom/ollama')

-- Make scrolloff go past end of the file
vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 5)
local scroll_eof_ok, scroll_eof = pcall(require, 'scrollEOF')
if scroll_eof_ok then
  scroll_eof.setup()
end
