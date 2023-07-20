local setup, nvim_tree = pcall(require, 'nvim-tree')
if not setup then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- remove some default keybindings to avoid conflicts
  vim.keymap.del('n', '<C-k>', { buffer = bufnr })
  vim.keymap.del('n', 'e', { buffer = bufnr })
  vim.keymap.del('n', 'd', { buffer = bufnr })

  -- custom mappings
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'dd', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'yP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

nvim_tree.setup({
  actions = {
    change_dir = {
      enable = false,
    },
    open_file = {
      window_picker = {
        enable = false
      },
    },
  },
  diagnostics = {
    enable = true,
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  on_attach = on_attach,
})
