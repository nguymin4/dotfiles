require('custom.explorer.nvim-tree')
require('custom.explorer.telescope')
require('custom.explorer.aerial')
require('custom.explorer.actions')

-- Make scrolloff go past end of the file
vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 5)
require('scrollEOF').setup()
